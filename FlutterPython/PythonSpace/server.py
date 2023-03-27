from flask import Flask,jsonify,request,render_template
import folium
import urllib.request
import json
from PIL import Image
import numpy as np
from tensorflow import keras

app=Flask('__main__')

# @app.route("/predict",methods=['GET','POST'])
# def showtest():
#     reslist=['어쿠스틱 기타','일렉트릭 기타','색소폰']
#     file=request.files['image']
#     image=Image.open(file)
#     imgConverted=image.resize((100,100)).convert('L')
#     imgArray=255-np.array(imgConverted).reshape(-1,100,100,1)
#     model=keras.models.load_model('./FlutterPython/PythonSpace/cnn_inst_model.h5')
#     result=reslist[int(np.argmax(model.predict(imgArray)))]
#     image.close()
#     imgConverted.close()

#     return json.dumps({'result': result},ensure_ascii=False)


@app.route("/predict", methods=['POST'])
def showtest():
    reslist = ['어쿠스틱 기타', '일렉트릭 기타', '색소폰']
    file = request.files['image']
    image = Image.open(file)
    imgConverted = image.resize((100, 100)).convert('L')
    imgArray = 255 - np.array(imgConverted).reshape(-1, 100, 100, 1)
    model = keras.models.load_model('./cnn_inst_model.h5')
    result = reslist[int(np.argmax(model.predict(imgArray)))]
    image.close()
    imgConverted.close()

    return jsonify({'result': result})

@app.route('/test')
def predicttest():
    return render_template('test.html')


@app.route("/map")
def showmap():
    loc=[37.5,126.9]
    my_map=folium.Map(location=loc,zoom_start=15)
    my_map.save('../Python/Note/templates/map.html')
    return render_template('map.html',variable=my_map)


if __name__=='__main__':
    app.run(host='127.0.0.1',port=5000,debug=True)
    app.config['JSON_AS_ASCII'] = False

##192.168.10.213