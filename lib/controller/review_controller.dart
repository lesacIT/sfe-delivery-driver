import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;

class ReviewController extends GetxController{

  getReview(from, to) async{
    final res=await http.get(
      Uri.parse(global.link+'/api/driver/review/list?from='+from.toString()+'&to='+to.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
}