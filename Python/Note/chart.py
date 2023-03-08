"""
Author: MirrorSpring
Date: 2023-03-08
Desc: 모델의 정확도와 손실을 차트로 시각화
"""

import matplotlib.pyplot as plt

def chart(history,valid=True,accuracy=True,figsize=(10,5)):
    fig=plt.figure(figsize=figsize)
    i=1
    if accuracy:
        i=2
    ax1=fig.add_subplot(1,i,1)

    ax1.plot(history.history['loss'])
    if valid:
        ax1.plot(history.history['val_loss'])
    ax1.legend(['train','valid'])
    ax1.set_title('Loss')
    ax1.set_xlabel('epoch')
    ax1.set_ylabel('loss')

    if accuracy:
        ax2=fig.add_subplot(1,2,2)
        ax2.plot(history.history['accuracy'])
        if valid:
            ax2.plot(history.history['val_accuracy'])
        ax2.legend(['train','valid'])
        ax2.set_title('Accuracy')
        ax2.set_xlabel('epoch')
        ax2.set_ylabel('accuracy')

    plt.show()