import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;
class OrderController extends GetxController{
  //var

  //method

  getOrder(status) async{
    final res=await http.get(
        Uri.parse(global.link+'/api/driver/order/list?status='+status.toString()),
        headers: {
          'Authorization':'Bearer '+global.token
        },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postAcceptOrder(id) async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/order/accept-order/'+id.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postRejectOrder(id) async{
    dynamic data=await global.postData('${global.link}/api/driver/order/reject-order/$id', {});
    return data;
  }

  postPickedCustomer(id) async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/order/picked-customer/'+id.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postCompleteOrder(id) async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/order/complete/'+id.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  getDetail(id) async{
    dynamic data=await global.getData('${global.link}/api/driver/order/detail/$id');
    return data;
  }
}