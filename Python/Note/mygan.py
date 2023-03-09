"""
Author: MirrorSpring
Desc: Making image from sample using GAN
"""

from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import tensorflow as tf

class MyGAN:
    __number_of_data=1 #데이터 수
    __img_width_size=100 #너비
    __img_height_size=100 #높이
    __channel=1 #채널 수(아직은 고정)
    __batch_size=5 #배치 사이즈
    __noise_dim=100 #화질 관련(아직은 고정)
    __generator_optimizer=keras.optimizers.Adam(1e-4) #생성자 경사 하강 알고리즘
    __discriminator_optimizer=keras.optimizers.Adam(1e-4) #판별자 경사 하강 알고리즘
    __generator=0 #생성자
    __discriminator=0 #판별자

    #생성자
    def __init__(self,number_of_data,width,height,batch_size):
        if (width%4)+(height%4)!=0:
            raise ValueError('높이와 너비는 4의 배수여야 합니다.')
        self.__number_of_data=number_of_data
        self.__img_height_size=height
        self.__img_width_size=width
        self.__batch_size=batch_size
        self.__generator=self.__build_generator_model()
        self.__discriminator=self.__build_discriminator_model()
    
    #배치 데이터셋 만들기
    def __makebatch(self,imgs):
        train=np.zeros(self.__number_of_data*self.__img_height_size*self.__img_width_size,dtype=np.int32).reshape(self.__number_of_data,self.__img_height_size,self.__img_width_size)
        i=0
        for image in sorted(imgs):
            img=Image.open(image)
            imgConverted=img.convert('L')
            imgConverted=imgConverted.resize((self.__img_height_size,self.__img_width_size))
            img=np.array(imgConverted,dtype=np.int32)
            train[i,:,:]=img
            i+=1

        x_train=train.reshape(train.shape[0],self.__img_height_size,self.__img_width_size,self.__channel)
        X=(x_train-127.5)/127.5
        train_dataset=tf.data.Dataset.from_tensor_slices(X).batch(self.__batch_size)

        return train_dataset
    
    #생성자 모델 생성
    def __build_generator_model(self):
        model = keras.Sequential() # Keras 모델 생성
    
        model.add(keras.layers.Dense(1024, input_dim=100, use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        model.add(keras.layers.Dense((self.__img_height_size/4)*(self.__img_width_size/4)*128, use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        model.add(keras.layers.Reshape((int(self.__img_height_size/4), int(self.__img_width_size/4), 128)))
        
        model.add(keras.layers.Conv2DTranspose(self.__img_height_size*4, (5, 5),
                                        strides=(1, 1), padding='same', use_bias=False))
        model.add(keras.layers.BatchNormalization()) 
        model.add(keras.layers.LeakyReLU())
        
        model.add(keras.layers.Conv2DTranspose(self.__img_width_size*2, (5, 5),
                                        strides=(2, 2), padding='same', use_bias=False))
        model.add(keras.layers.BatchNormalization())
        model.add(keras.layers.LeakyReLU())
        
        model.add(keras.layers.Conv2DTranspose(1, (5, 5), 
                                        strides=(2, 2), padding='same', activation='tanh'))
        assert model.output_shape == (None, self.__img_height_size, self.__img_width_size, 1)
    
        return model

    #판별자 모델 생성
    def __build_discriminator_model(self):

        model = keras.Sequential()
    
        model.add(keras.layers.Conv2D(self.__img_height_size*2, (5, 5), strides=2, padding='same',  # 56 = 28 * 2
                       input_shape=[self.__img_height_size, self.__img_width_size, 1])) # input image size
        model.add(keras.layers.LeakyReLU(0.2))
        model.add(keras.layers.Dropout(0.3))

        model.add(keras.layers.Conv2D(self.__img_height_size*4, (5, 5), strides=2, padding='same')) # 112 = 56 * 2
        model.add(keras.layers.LeakyReLU(0.2))
    
        model.add(keras.layers.Flatten())
    
        model.add(keras.layers.Dense(self.__img_height_size*4*2)) # 224 = 112 * 2
        model.add(keras.layers.LeakyReLU(0.2))
        model.add(keras.layers.Dropout(0.3))

        model.add(keras.layers.Dense(1))
    
        return model
    
    #생성자 손실 함수
    def __generator_loss(self,fake_output):
        cross_entropy=keras.losses.BinaryCrossentropy(from_logits=True)
        return cross_entropy(tf.ones_like(fake_output),fake_output)
    
    #판별자 손실 함수
    def __discriminator_loss(self,real_output,fake_output):
        cross_entropy=keras.losses.BinaryCrossentropy(from_logits=True)
        real_loss=cross_entropy(tf.ones_like(real_output),real_output) #1과 진짜 이미지 판별 값 비교
        fake_loss=cross_entropy(tf.zeros_like(fake_output),fake_output) #0과 가짜 이미지 판별 값 비교
        total_loss=real_loss+fake_loss
        return total_loss
    
    #학습 과정
    @tf.function
    def __train_step(self,images):

        # 생성자 input noise
        noise = tf.random.normal([self.__batch_size, self.__noise_dim])
        # Gradient descent 계산 및 파라미터 업데이트
        with tf.GradientTape() as gen_tape, tf.GradientTape() as disc_tape:
            generated_images = self.__generator(noise, training=True)
    
            real_output = self.__discriminator(images, training=True)
            fake_output = self.__discriminator(generated_images, training=True)
    
            gen_loss = self.__generator_loss(fake_output)
            disc_loss = self.__discriminator_loss(real_output, fake_output)
    
        gradients_of_generator = gen_tape.gradient(gen_loss, self.__generator.trainable_variables)
        gradients_of_discriminator = disc_tape.gradient(disc_loss, self.__discriminator.trainable_variables)
    
        self.__generator_optimizer.apply_gradients(zip(gradients_of_generator, self.__generator.trainable_variables))
        self.__discriminator_optimizer.apply_gradients(zip(gradients_of_discriminator, self.__discriminator.trainable_variables))

    #학습 과정 시각화
    def __show_generated_images(self,epoch):
        test_noise = tf.random.normal([10, self.__noise_dim])
        images = self.__generator.predict(test_noise)
        images = 0.5 * images + 0.5 # tanh는 sigmoid보다 데이터 범위가 2배가 더 크므로 이를 조정 
        
        plt.figure(figsize=(11,5))
        
        i = 1
        for image in images:
            image = image.reshape(self.__img_width_size, self.__img_height_size)
            plt.subplot(2, 5, i)
            plt.imshow(image, cmap='gray')
            plt.axis('off')
            i+=1
    
        plt.suptitle("Generated Images on EPOCH: %s" % epoch, fontsize = 25)
        plt.show()
    
    #훈련 시작
    @tf.autograph.experimental.do_not_convert
    def train(self,dataset,epochs=1000,show_freq=5):
        data=self.__makebatch(dataset)
        for epoch in range(epochs):
            for image_batch in data:
                self.__train_step(image_batch)
            if epoch%show_freq==0:
                self.__show_generated_images(epoch)

    #이미지 생성 후 저장
    def saveimage(self,num_res,dirstr,prefix):
        test_noise = tf.random.normal([num_res, self.__noise_dim])
        images = self.__generator.predict(test_noise)
        i=1
        for image in images:
            img=Image.fromarray(((image)*127.5+127.5).astype('uint8').reshape(100,100),'L')
            img.save(f'{dirstr}/{prefix}{i}.jpg', 'JPEG')
            i+=1

    #결과 시각화
    def showimage(self,figsize):
        test_noise = tf.random.normal([1, self.__noise_dim])
        plt.figure(figsize=figsize)
        images = self.__generator.predict(test_noise)
        images = 0.5 * images + 0.5
        image = image[0].reshape(self.__img_width_size, self.__img_height_size)
        plt.imshow(image, cmap='gray')
        plt.axis('off')
        plt.show()
