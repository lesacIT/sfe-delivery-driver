import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;

class WalletController extends GetxController{

  getWallet(from, to) async{
    final res=await http.get(
      Uri.parse(global.link+'/api/driver/wallet/list?from='+from.toString()+'&to='+to.toString()),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
  postWithdraw(withdraw) async{
    final res=await http.post(
      Uri.parse(global.link+'/api/driver/wallet/request-withdraw'),
      headers: {
        'Authorization':'Bearer '+global.token
      },
      body: {
         "withdraw": withdraw,
      }

    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
  getListRequestWithdraw(from, to, status) async{
    final res=await http.get(
      Uri.parse(global.link+'/api/driver/wallet/list-request-withdraw?from='+from.toString()+'&to='+to.toString()+'&status='+status),
      headers: {
        'Authorization':'Bearer '+global.token
      },
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
}