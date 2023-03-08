"""
Author: MirrorSpring
Date: 2023-03-08
Desc: 샘플로 준 이미지와 유사한 이미지를 생성하는 모델
"""


from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import tensorflow as tf

class MyGAN:
    number_of_data=1
    img_width_size=100
    img_height_size=100
    channel=1
    batch_size=5
    noise_dim=30
    generator_optimizer=keras.optimizers.Adam(1e-4)
    discriminator_optimizer=keras.optimizers.Adam(1e-4)
    generator=0
    discriminator=0

    def __init__(self,number_of_data,width,height,batch_size,channel=1,noise_dim=30):
        if (width%4)+(height%4)!=0:
            raise ValueError('높이와 너비는 4의 배수여야 합니다.')
        self.number_of_data=number_of_data
        self.img_height_size=height
        self.img_width_size=width
        self.channel=channel
        self.batch_size=batch_size
        self.noise_dim=noise_dim
        self.generator=self.build_generator_model()
        self.discriminator=self.build_discriminator_model()
    
    def makebatch(self,imgs):
        train=np.zeros(self.number_of_data*self.img_height_size*self.img_width_size,dtype=np.int32).reshape(self.number_of_data,self.img_height_size,self.img_width_size)
        i=0
        for image in sorted(imgs):
            img=Image.open(image)
            imgConverted=img.convert('L')
            imgConverted=imgConverted.resize((100,100))
            img=np.array(imgConverted,dtype=np.int32)
            train[i,:,:]=img
            i+=1

        x_train=train.reshape(train.shape[0],self.img_height_size,self.img_width_size,self.channel)
        X=(x_train-127.5)/127.5
        train_dataset=tf.data.Dataset.from_tensor_slices(X).batch(self.batch_size)

        return train_dataset
    
    def build_generator_model(self):
        model = keras.Sequential() # Keras 모델 생성
    
        model.add(keras.layers.Dense(1024, input_dim=30, use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        model.add(keras.layers.Dense((self.img_height_size/4)*(self.img_width_size/4)*128, use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        # Resahpe (7*7)
        model.add(keras.layers.Reshape((int(self.img_height_size/4), int(self.img_width_size/4), 128)))
        
        model.add(keras.layers.Conv2DTranspose(self.img_height_size*4, (5, 5),
                                        strides=(1, 1), padding='same', use_bias=False))
        model.add(keras.layers.BatchNormalization()) 
        model.add(keras.layers.LeakyReLU())
        
        # (7*7) -> (14*14)
        model.add(keras.layers.Conv2DTranspose(self.img_width_size*2, (5, 5), # 28 * 2
                                        strides=(2, 2), padding='same', use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        # (14*14) -> (28*28)
        model.add(keras.layers.Conv2DTranspose(1, (5, 5), 
                                        strides=(2, 2), padding='same', activation='tanh'))
        assert model.output_shape == (None, self.img_height_size, self.img_width_size, 1)
    
        return model

    def build_discriminator_model(self):

        model = keras.Sequential()
    
        model.add(keras.layers.Conv2D(self.img_height_size*2, (5, 5), strides=2, padding='same',  # 56 = 28 * 2
                       input_shape=[self.img_height_size, self.img_width_size, 1])) # input image size
        model.add(keras.layers.LeakyReLU(0.2))
        model.add(keras.layers.Dropout(0.3))

        model.add(keras.layers.Conv2D(self.img_height_size*4, (5, 5), strides=2, padding='same')) # 112 = 56 * 2
        model.add(keras.layers.LeakyReLU(0.2))
    
        model.add(keras.layers.Flatten())
    
        model.add(keras.layers.Dense(self.img_height_size*4*2)) # 224 = 112 * 2
        model.add(keras.layers.LeakyReLU(0.2))
        model.add(keras.layers.Dropout(0.3))

        model.add(keras.layers.Dense(1))
    
        return model
    
    def generator_loss(self,fake_output):
        cross_entropy=keras.losses.BinaryCrossentropy(from_logits=True)
        return cross_entropy(tf.ones_like(fake_output),fake_output)
    
    def discriminator_loss(self,real_output,fake_output):
        cross_entropy=keras.losses.BinaryCrossentropy(from_logits=True)
        real_loss=cross_entropy(tf.ones_like(real_output),real_output) #1과 진짜 이미지 판별 값 비교
        fake_loss=cross_entropy(tf.zeros_like(fake_output),fake_output) #0과 가짜 이미지 판별 값 비교
        total_loss=real_loss+fake_loss
        return total_loss
    
    @tf.function
    def train_step(self,images):

        # 생성자 input noise
        noise = tf.random.normal([self.batch_size, self.noise_dim])
        # Gradient descent 계산 및 파라미터 업데이트
        with tf.GradientTape() as gen_tape, tf.GradientTape() as disc_tape:
            generated_images = self.generator(noise, training=True)
    
            real_output = self.discriminator(images, training=True)
            fake_output = self.discriminator(generated_images, training=True)
    
            gen_loss = self.generator_loss(fake_output)
            disc_loss = self.discriminator_loss(real_output, fake_output)
    
        gradients_of_generator = gen_tape.gradient(gen_loss, self.generator.trainable_variables)
        gradients_of_discriminator = disc_tape.gradient(disc_loss, self.discriminator.trainable_variables)
    
        self.generator_optimizer.apply_gradients(zip(gradients_of_generator, self.generator.trainable_variables))
        self.discriminator_optimizer.apply_gradients(zip(gradients_of_discriminator, self.discriminator.trainable_variables))

    test_noise = tf.random.normal([10, noise_dim])

    def show_generated_images(self,epoch):
        images = self.generator.predict(self.test_noise)
        images = 0.5 * images + 0.5 # tanh는 sigmoid보다 데이터 범위가 2배가 더 크므로 이를 조정 
        
        plt.figure(figsize=(11,5))
        
        i = 1
        for image in images:
            image = image.reshape(self.img_width_size, self.img_height_size)
            plt.subplot(2, 5, i)
            plt.imshow(image, cmap='gray')
            plt.axis('off')
            i+=1
    
        plt.suptitle("Generated Images on EPOCH: %s" % epoch, fontsize = 25)
        plt.show()
    
    def train(self,dataset,epochs,show_freq):
        for epoch in range(epochs):
            for image_batch in dataset:
                self.train_step(image_batch)
            if epoch%show_freq==0:
                self.show_generated_images(epoch)