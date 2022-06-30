import 'package:flutter/material.dart';

class UserData{
  String seciliCinsiyet;
  double sigaraSayisi;
  double sporSayisi;
  int height;
  int weight;

  UserData({required this.seciliCinsiyet,required this.sigaraSayisi,required this.sporSayisi,required this.height,required this.weight});


  String getSex(){
  return seciliCinsiyet;
  }

  double getSmoke(){
    return sigaraSayisi;
  }

  double getWorkOut(){
    return sporSayisi;
  }

  int getHeight(){
    return height;
  }

  int getWeight(){
    return weight;
  }
}