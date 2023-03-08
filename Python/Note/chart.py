import matplotlib.pyplot as plt

def chart(history):
    fig=plt.figure(figsize=(10,5))
    ax1=fig.add_subplot(1,2,1)
    ax2=fig.add_subplot(1,2,2)

    ax1.plot(history.history['loss'])
    ax1.plot(history.history['val_loss'])
    ax1.legend(['train','valid'])
    ax1.set_title('Loss')
    ax1.set_xlabel('epoch')
    ax1.set_ylabel('loss')

    ax2.plot(history.history['accuracy'])
    ax2.plot(history.history['val_accuracy'])
    ax2.legend(['train','valid'])
    ax2.set_title('Accuracy')
    ax2.set_xlabel('epoch')
    ax2.set_ylabel('accuracy')

    plt.show()