# python_inst

## 라이브러리
### mygan
- 샘플로 준 이미지와 유사한 이미지를 생성하는 모델입니다.
- 이미지는 디렉토리의 배열입니다. `glob`을 사용해도 무방합니다.
- `height`와 `width`는 4의 배수여야 합니다.
- 사용 예시
```
from mygan import MyGAN

mgan=MyGAN(1,100,100,5)
trainset=mgan.makebatch(['../Data/gogh1.jpg'])
mgan.train(trainset)
```
### chart
- 딥러닝 모델의 정확도(accuracy)와 손실(loss)을 차트로 시각화하는 모듈입니다.
- `model.fit`에 `validation_data`가 있어야 합니다.
- 사용 예시
```
from chart import chart

chart(history)
```

![image](https://user-images.githubusercontent.com/80088464/223640515-b1a36143-9fd5-430d-8187-162976c0dd9d.png)
