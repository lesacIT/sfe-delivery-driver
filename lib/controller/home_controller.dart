import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;

class HomeController extends GetxController{
  getHome() async{
    dynamic data=await global.getData('${global.link}/api/driver/home/home');
    return data;
  }
}