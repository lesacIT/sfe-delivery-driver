import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  //var

  //method
  postLogin(phone,password,fbToken) async{
    final res=await http.post(
        Uri.parse(global.link+'/api/driver/auth/login'),
        headers: {

        },
        body: {
          "phone":phone,
          "password":password,
          "token":fbToken
        }
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }
  postChangePassword(old_password, new_password) async{
    final res=await http.post(
        Uri.parse(global.link+'/api/driver/auth/change-password'),
        headers: {
          'Authorization': 'Bearer '+global.token
        },
        body: {
          "old_password": old_password,
          "new_password": new_password,
        }
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postChangeStatus(status) async{
    final res=await http.post(
        Uri.parse(global.link+'/api/driver/auth/change-status'),
        headers: {
          'Authorization': 'Bearer '+global.token
        },
        body: {
          "status": status,
        }
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postRegister(name,phone, password,phone_zalo, ma_giam_sat,anh_chan_dung,cccd, anh_mat_truoc_cccd, anh_mat_sau_cccd,loai_dich_vu, bien_so_xe, hang_xe, mat_truoc_gplx, mat_sau_gplx,mat_truoc_giay_to_xe,mat_sau_giay_to_xe, ten_ngan_hang, ten_chu_tai_khoan, so_tai_khoan) async{
    dynamic body={
      "name": name,
      "phone": phone,
      "password": password,
      "phone_zalo": phone_zalo,
      "ma_giam_sat": ma_giam_sat,
      "anh_chan_dung": anh_chan_dung,
      "cccd": cccd,
      "anh_mat_truoc_cccd": anh_mat_truoc_cccd,
      "anh_mat_sau_cccd": anh_mat_sau_cccd,
      "loai_dich_vu":loai_dich_vu,
      "bien_so_xe":bien_so_xe,
      "hang_xe": hang_xe,
      "mat_truoc_gplx":mat_truoc_gplx,
      "mat_sau_gplx":mat_sau_gplx,
      "mat_truoc_giay_to_xe":mat_truoc_giay_to_xe,
      "mat_sau_giay_to_xe":mat_sau_giay_to_xe,
      "ten_ngan_hang":ten_ngan_hang,
      "chu_tai_khoan":ten_chu_tai_khoan,
      "so_tai_khoan":so_tai_khoan,
    };
    dynamic data=global.postData('${global.link}/api/driver/auth/register', body);
    return data;
  }

  postUpdateinfo(name, avatar) async{
    final res=await http.post(
        Uri.parse(global.link+'/api/driver/auth/update-info'),
        headers: {
          'Authorization': 'Bearer '+global.token
        },
        body: {
          'name': name,
          'avatar':avatar,
        }
    ).timeout(const Duration(seconds: 15), onTimeout: (){ return http.Response('{"Errors":408,"MessageErrors":"Timeout"}',408); });
    dynamic data=jsonDecode(res.body);
    return data;
  }

  postUpdateLocation(lat,long) async{
    dynamic body={
      'lat':lat.toString(),
      'long':long.toString()
    };
    dynamic data=await global.postData('${global.link}/api/driver/auth/update-location', body);
  }

  getBankList() async{
    List list=[];
    dynamic data=await global.getData('${global.vietQrBaseUrl}/v2/banks');
    if(data['code']=='00'){
      list=data['data'];
    }
    return list;
  }

  getAccount() async{
    SharedPreferences storage= await SharedPreferences.getInstance();
    String accountString=storage.getString('account').toString();
    dynamic data={
      'username':'',
      'password':'',
    };
    if(accountString!='null' && accountString!=''){
      data=jsonDecode(accountString);
    }
    return data;
  }

  saveAccount(username,password) async{
    SharedPreferences storage= await SharedPreferences.getInstance();
    dynamic data={
      'username':username,
      'password':password
    };
    storage.setString('account', jsonEncode(data));
  }

  removeAccount() async{
    SharedPreferences storage= await SharedPreferences.getInstance();
    storage.remove('account');
  }
}