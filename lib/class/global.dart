import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//var
String link='https://sfedelivery.superweb.xyz';
String baseUrl='https://rsapi.goong.io';
String vietQrBaseUrl='https://api.vietqr.io';
String borderImgPath='assets/border.png';
String token='';
String goongKey='Ez48Sni1iU3wHIP9Wz58dpbCFD0X7Ze9ckTA7SyH';
String socketUrl='http://103.110.85.135:8899/';
Color gold= const Color.fromRGBO(252, 227, 3, 1);
Color black= const Color.fromRGBO(34, 34, 34, 1);
Color black1= const Color.fromRGBO(40, 40, 40, 1);
Color grey= const Color.fromRGBO(184, 184, 181, 1);
Color yellow= const Color.fromRGBO(237, 242, 1, 1);
String backgroundImage='assets/bg.png';
String backgroundImage1='assets/bg1.png';
List listLDV=[
  {'id':'tai_4_cho','name':'Tài xế 4 chỗ'},
  {'id':'tai_7_cho','name':'Tài xế 7 chỗ'},
  {'id':'tai_xe_may','name':'Tài xế xe máy'},
  {'id':'xe_om','name':'Xe ôm'},
];
dynamic user;
bool statusOnline=false;
dynamic currentOrder;

//method
postData(url,body) async{
  final res=await http.post(
      Uri.parse(url),
      headers: {
        'Authorization':'Bearer $token'
      },
      body: body
  ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
  dynamic data=jsonDecode(res.body);
  return data;
}

getData(url) async{
  final res=await http.get(
    Uri.parse(url),
    headers: {
      'Authorization':'Bearer $token'
    },
  ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
  dynamic data=jsonDecode(res.body);
  return data;
}


showSuccess(message){
  BotToast.showText(
      text: message.toString(),
      contentColor: Colors.green,
      align: const Alignment(0, -0),
      contentPadding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      clickClose: true
  );
}

showError(message){
  BotToast.showText(
      text: message.toString(),
      contentColor: Colors.red,
      align: const Alignment(0, -0),
      contentPadding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      clickClose: true
  );
}

showLoading(){
  BotToast.showLoading();
}

hideLoading(){
  BotToast.closeAllLoading();
}