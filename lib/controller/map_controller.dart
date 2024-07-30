import 'dart:convert';

import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  getDirections(latFrom, longFrom, latTo, longTo) async {
    String polyEncoded = '';
    final res = await http.get(Uri.parse(
        '${global.baseUrl}/Direction?origin=$latFrom,$longFrom&destination=$latTo,$longTo&vehicle=car&api_key=${global.goongKey}'));
    dynamic data = jsonDecode(res.body);
    if (data != null) {
      if (data['routes'] != null) {
        if (data['routes'].length > 0) {
          if (data['routes'][0]['overview_polyline'] != null) {
            polyEncoded = data['routes'][0]['overview_polyline']['points'];
          }
        }
      }
    }
    return polyEncoded;
  }
}
