# python_inst

## 라이브러리
### mygan
- `height`와 `width`는 4의 배수여야 합니다.
- 사용 예시
```
from mygan import MyGAN

mgan=MyGAN(1,100,100,5)
trainset=mgan.makebatch(['../Data/gogh1.jpg'])
mgan.train(trainset)
```
### chart
- `model.fit`에 `validation_data`가 있어야 합니다.
- 사용 예시
```
from chart import chart

chart(history)
```

![image](https://user-images.githubusercontent.com/80088464/223640515-b1a36143-9fd5-430d-8187-162976c0dd9d.png)
