import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;
class NotificationController extends GetxController{
  //var

  //method

  getNotification() async{
    final res=await http.get(
        Uri.parse(global.link+'/api/driver/notification/list'),
        headers: {
          'Authorization':'Bearer '+global.token
        },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
  postMarkAsRead(id) async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/notification/mark-as-read/'+id.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
  postMarkAsReadAll() async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/notification/mark-as-read-all'),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
}