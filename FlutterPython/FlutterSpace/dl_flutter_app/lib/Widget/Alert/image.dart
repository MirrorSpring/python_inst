import 'package:flutter/material.dart';

class Imagetemp {
  late int temp;
  tempImage(temp) {
    if (temp >= 80) {
      return Image.network("http://localhost:8080/images/80.png",
          width: 35, height: 35, fit: BoxFit.fill);
    } else if (temp >= 65) {
      return Image.network("http://localhost:8080/images/65.png",
          width: 35, height: 35, fit: BoxFit.fill);
    } else if (temp >= 50) {
      return Image.network("http://localhost:8080/images/50.png",
          width: 35, height: 35, fit: BoxFit.fill);
    } else if (temp >= 35) {
      return Image.network("http://localhost:8080/images/35.png",
          width: 35, height: 35, fit: BoxFit.fill);
    } else {
      return Image.network("http://localhost:8080/images/20.png",
          width: 35, height: 35, fit: BoxFit.fill);
    }
  }
}
