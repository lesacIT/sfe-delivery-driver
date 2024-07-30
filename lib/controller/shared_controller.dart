import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:deliverydriver/class/global.dart' as global;

class SharedController extends GetxController{

  postUploadImage(path) async{
    var request=http.MultipartRequest('POST',Uri.parse('${global.link}/api/shared/upload-image'));
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', path);
    request.files.add(multipartFile);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    dynamic data=jsonDecode(res.body);
    return data;
  }
}