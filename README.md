# python_inst

## 라이브러리
### mygan
- 샘플로 준 이미지와 유사한 이미지를 생성하는 모델입니다.
- 이미지는 디렉토리의 배열입니다. `glob`을 사용해도 무방합니다.
- `height`와 `width`는 4의 배수여야 합니다.
- 매개 변수
  - Constructor
    - `number_of_data`: 샘플 이미지 개수입니다.
    - `width`: 생성하려고 하는 이미지의 너비입니다(샘플 이미지 원본과는 관계없지만, `width`와 `height`의 비를 원본과 비슷하게 하는 것을 권장합니다.). 4의 배수여야 합니다.
    - `height`: 생성하려고 하는 이미지의 높이입니다(샘플 이미지 원본과는 관계없지만, `width`와 `height`의 비를 원본과 비슷하게 하는 것을 권장합니다.). 4의 배수여야 합니다.
    - `batch_size`: 배치 사이즈입니다.
  - ~~`makebatch`: `train`을 위한 데이터셋을 만듭니다.~~
  ~~  - `imgs`: 이미지 파일 이름의 리스트입니다.~~
  - `train`: 이미지 생성을 위해 학습합니다.
    - `dataset`: `makebatch`를 통해 만든 데이터셋입니다.
    - `epochs`: 반복 학습 횟수입니다. 기본값은 1000입니다.
    - `show_freq`: 몇 번째 epoch마다 생성한 이미지를 보여 줄 지에 대한 매개 변수입니다. 기본값은 5입니다.
  - `saveimage`: 이미지를 생성하고 저장합니다. `.jpg` 파일로 저장됩니다.
    - `num_res`: 생성할 이미지의 개수입니다.
    - `dir`: 이미지를 저장할 디렉토리입니다. 마지막에 /는 생략합니다.
    - `prefix`: 저장될 이미지의 이름입니다. 이름 뒤에 1부터 숫자가 붙습니다.
  - `showimage`: 이미지를 생성하고 시각화합니다.
    - `figsize`: 튜플 형식의 이미지 크기입니다.
    
- 사용 예시
```
from mygan import MyGAN

mgan=MyGAN(1,100,100,5)
mgan.train(['../Data/gogh1.jpg'],show_freq=10)
mgan.showimage(figsize=(15,15))
mgan.saveimage(num_res=100,dir='../Data',prefix='sample')
```
### chart
- 딥러닝 모델의 정확도(accuracy)와 손실(loss)을 차트로 시각화하는 모듈입니다.
- ~~`model.fit`에 `validation_data`가 있어야 합니다.~~ &rarr; 필요 없어졌습니다.
- 매개 변수
  - `history`: `keras` 딥러닝 모델입니다.
  - `accuracy`: 정확도 표시 여부입니다. 기본값은 `True`입니다.
  - `valid`: 검증 데이터 표시 여부입니다. 기본값은 `True`입니다.
  - `figsize`: 차트 크기입니다. 튜플 형식입니다. 기본값은 (10,5)입니다.
- 사용 예시
```
from tensorflow import keras
from chart import chart

model=keras.Sequential()
model.add(keras.layers.Dense(100,activation='relu'))
model.add(keras.layers.Dense(3,activation='softmax'))

model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics='accuracy')
checkpoint_cb=keras.callbacks.ModelCheckpoint('../Data/best_cnn_model.h5')
earlystopping_cb=keras.callbacks.EarlyStopping(patience=3,restore_best_weights=True)
history=model.fit(data,target,epochs=20,validation_data=(valData,valTargetData),callbacks=[checkpoint_cb,earlystopping_cb])

chart(history,accruacy=True)
```

![image](https://user-images.githubusercontent.com/80088464/223640515-b1a36143-9fd5-430d-8187-162976c0dd9d.png)
