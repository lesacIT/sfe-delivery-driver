import 'dart:async';
import 'dart:convert';

import 'package:deliverydriver/controller/map_controller.dart';
import 'package:deliverydriver/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as MapsToolkit;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOrderView extends StatefulWidget {
  dynamic order;
  bool check;

  DetailOrderView({super.key,required this.order,required this.check});

  @override
  State<DetailOrderView> createState() => _DetailOrderViewState(order,check);
}

class _DetailOrderViewState extends State<DetailOrderView> {
  dynamic order;
  bool check;
  _DetailOrderViewState(this.order,this.check);
  //var
  OrderController orderController=Get.find();
  MapController mapController=Get.find();
  var numberFormat=NumberFormat('#,###','en_US');
  dynamic detail;
  late IO.Socket socket;
  Location location=Location();
  BitmapDescriptor? customDriverIcon;
  LatLng? driverLocation;
  List<LatLng> directionLine=[];
  final Completer<GoogleMapController> ggMapController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
        'assets/driver_location.png')
        .then((d) {
      customDriverIcon = d;
    });
    connectSocket();
    getDetail();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  connectSocket() async{
    socket = IO.io(global.socketUrl, IO.OptionBuilder().setTransports(['websocket']).enableForceNew().build());
    socket.onConnect((_) async{
      socket.emit('joinOrder',{'order_id':order['id']});
    });
    socket.on('getDriverLocation', (data) async{
      dynamic resp=jsonDecode(data);
      driverLocation=LatLng(double.parse(resp['lat'].toString()), double.parse(resp['long'].toString()));
      setState(() {

      });
    });
    socket.onDisconnect((_){});
  }

  String getCTTenXe(car_type){
    String result='';
    if(car_type=='2'){
      result='Xe máy';
    }
    else if(car_type=='4'){
      result='Xe 4 chỗ';
    }
    else if( car_type=='7'){
      result='Xe 7 chỗ';
    }
    return result;
  }

  getDetail()async{
    global.showLoading();
    LocationData driverL=await location.getLocation();
    driverLocation=LatLng(driverL.latitude!, driverL.longitude!);
    dynamic data = await orderController.getDetail(order['id']);
    global.hideLoading();
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      global.showLoading();
      detail=data['data'];
      if(detail['status']=='picking_customer'){
        String polyEncoded=await mapController.getDirections(driverL.latitude, driverL.longitude, detail['lat_from'], detail['long_from']);
        var path=MapsToolkit.PolygonUtil.decode(polyEncoded);
        directionLine=[];
        for(dynamic item in path) {
          directionLine.add(LatLng(item.latitude, item.longitude));
        }
        final GoogleMapController controller = await ggMapController.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: driverLocation!,
            zoom: 17
        )));
      }
      else if(detail['status']=='moving'){
        String polyEncoded=await mapController.getDirections(driverL.latitude, driverL.longitude, detail['lat_to'], detail['long_to']);
        var path=MapsToolkit.PolygonUtil.decode(polyEncoded);
        directionLine=[];
        for(dynamic item in path) {
          directionLine.add(LatLng(item.latitude, item.longitude));
        }
        final GoogleMapController controller = await ggMapController.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: driverLocation!,
            zoom: 17
        )));
      }
      global.hideLoading();
      setState(() {

      });
    }
  }

  completeOrder() async{
    global.showLoading();
    dynamic data = await orderController.postCompleteOrder(order['id']);
    global.hideLoading();
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      if(global.currentOrder!=null){
        if(order['id']==global.currentOrder['id']){
          global.currentOrder=null;
        }
      }
      global.showSuccess(data['message']);
      getDetail();
    }
  }

  pickedCustomer() async{
    global.showLoading();
    dynamic data = await orderController.postPickedCustomer(order['id']);
    global.hideLoading();
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      global.showSuccess(data['message']);
      getDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Chi tiết đặt xe', style: TextStyle(color: global.gold),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, color: global.gold,),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(global.borderImgPath),
                  fit: BoxFit.fill
                )
              ),
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: detail!=null?Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            ggMapController.complete(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(detail['lat_from'],detail['long_from']),
                            zoom: 14
                          ),
                          markers: {
                            if(detail['status']=='picking_customer')
                              Marker(
                                markerId: const MarkerId('from'),
                                position: LatLng(order['lat_from'],order['long_from']),
                              ),
                            if(detail['status']=='moving')
                              Marker(
                                markerId: const MarkerId('to'),
                                position: LatLng(detail['lat_to'],detail['long_to']),
                              ),
                            if(driverLocation!=null)
                              Marker(
                                markerId: const MarkerId('driver'),
                                position: driverLocation!,
                                icon: customDriverIcon!
                              )
                          },
                          polylines: {
                            if(directionLine.isNotEmpty)
                              Polyline(
                                polylineId: const PolylineId("target"),
                                points: directionLine,
                                color: global.gold
                              )
                          },
                        ),
                      ):Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(global.backgroundImage1),
                              fit: BoxFit.fill
                          )
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${detail!=null?detail['distance'].toString():''} km', style: TextStyle(color: global.gold, fontSize: 16),),
                                  Text(DateFormat('dd/MM/yyy HH:mm').format(DateTime.parse(detail!=null?detail['created_at']:'2024-01-01')), style: TextStyle(color: global.gold, fontSize: 16))
                                ],
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Điểm xuất phát: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                    TextSpan(text: (detail!=null?detail['address_from']:''), style: TextStyle(color: global.gold, fontSize: 16))
                                  ]
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Điểm đến: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                    TextSpan(text: (detail!=null?detail['address_to']:''), style: TextStyle(color: global.gold, fontSize: 16))
                                  ]
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Loại xe: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                        TextSpan(text: getCTTenXe(detail!=null?detail['car_type'].toString():''), style: TextStyle(color: global.gold, fontSize: 16))
                                      ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Tổng tiền: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                        TextSpan(text: numberFormat.format(detail!=null?detail['total']:0), style: TextStyle(color: global.gold, fontSize: 16))
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Khách hàng: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                        TextSpan(text: detail!=null?detail['customer']['name']:'', style: TextStyle(color: global.gold, fontSize: 16))
                                      ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: (){
                                    launchUrl(Uri.parse("tel:${detail['customer']['phone']}"));
                                  },
                                  child: Container(
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: global.gold,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text('Gọi',textAlign: TextAlign.center ,style: TextStyle(fontWeight:FontWeight.bold,color: global.black, fontSize: 16)),
                                  ),
                                )
                              ),
                            ],
                          ),
                          if(detail!=null && detail['status']=='picking_customer')
                            InkWell(
                              onTap: (){
                                pickedCustomer();
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: global.gold,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: Text('Đã đón khách',textAlign: TextAlign.center ,style: TextStyle(fontWeight:FontWeight.bold,color: global.black, fontSize: 16)),
                              ),
                            ),
                          if(detail!=null && detail['status']=='moving')
                            InkWell(
                              onTap: (){
                                completeOrder();
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: global.gold,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: Text('Hoàn thành',textAlign: TextAlign.center ,style: TextStyle(fontWeight:FontWeight.bold,color: global.black, fontSize: 16)),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Container(
              width: double.infinity,
              height: 20,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(global.borderImgPath),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
