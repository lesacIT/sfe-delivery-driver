import 'dart:async';
import 'dart:convert';
import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/order_controller.dart';
import 'package:deliverydriver/view/account_view.dart';
import 'package:deliverydriver/view/detail_order_view.dart';
import 'package:deliverydriver/view/home_view.dart';
import 'package:deliverydriver/view/notification_view.dart';
import 'package:deliverydriver/view/order_view.dart';
import 'package:deliverydriver/view/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver{
  //var
  final PageStorageBucket bucket=PageStorageBucket();
  Widget currentView=const HomeView();
  int currentTab=0;
  late IO.Socket socket;
  AuthController authController=Get.find();
  OrderController orderController=Get.find();
  Location location=Location();
  Timer? timerLocation;
  Timer? timerOrder;
  Timer? timerAcceptOrder;
  ValueNotifier<int> countDownAcceptOrder=ValueNotifier(0);

  //method
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    connectSocket();
    updateLocation();
    sendLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    socket.disconnect();
    timerLocation?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    switch (state) {
      case AppLifecycleState.resumed:

        break;
      case AppLifecycleState.inactive:

        break;
      case AppLifecycleState.paused:

        break;
      case AppLifecycleState.detached:
        socket.emit('driverOffline',{'driver_id':global.user['id'],'token':global.token});
        break;
      case AppLifecycleState.hidden:

        break;
    }
  }

  connectSocket() async{
    socket = IO.io(global.socketUrl, IO.OptionBuilder().setTransports(['websocket']).enableForceNew().build());
    socket.onConnect((_) async{
      socket.emit('joinDriver',{'driver_id':global.user['id']});
    });
    socket.on('getNotifyOrder', (data) async{
      dynamic resp=jsonDecode(data);
      dynamic order=await orderController.getDetail(resp['order_id']);
      if(!order['error']){
        showOrder(order['data'],resp['list_id']);
      }
    });
    socket.onDisconnect((_){

    });
  }

  updateLocation() async{
    LocationData myL=await location.getLocation();
    authController.postUpdateLocation(myL.latitude, myL.longitude);
    timerLocation?.cancel();
    timerLocation=Timer.periodic(const Duration(seconds: 30), (timer) async{
      if(global.statusOnline){
        LocationData myL=await location.getLocation();
        authController.postUpdateLocation(myL.latitude, myL.longitude);
      }
    });
  }

  Widget itemBottomBar(VoidCallback onTap, icon, text, active){
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(icon,color: active?global.gold:global.grey,),
          Text(text, style: TextStyle(color: active?global.gold:global.grey,fontSize: 14),)
        ],
      ),
    );
  }

  rejectOrder(order,List listDriver) async{
    dynamic data = await orderController.postRejectOrder(order['id']);
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      if(listDriver.isNotEmpty){
        List itemRemain=[];
        String driverId=listDriver[0];
        if(listDriver.length>1){
          for(int i=1;i<listDriver.length;i++){
            itemRemain.add(listDriver[i]);
          }
        }
        socket.emit('notifyOrder',{'list_id':itemRemain,'driver_id':driverId,'order_id':order['id']});
      }
      else{
        socket.emit('noDriver',{'order_id':order['id']});
      }
      global.showSuccess(data['message']);
    }
    global.currentOrder=null;
    Get.back();
  }

  acceptOrder(order) async{
    global.showLoading();
    dynamic data = await orderController.postAcceptOrder(order['id']);
    global.hideLoading();
    Get.back();
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      global.showSuccess(data['message']);
      timerAcceptOrder?.cancel();
      global.currentOrder=order;
      socket.emit('statusOrder',{'status':'accept','order_id':order['id']});
      await Get.to(()=>DetailOrderView(order: order, check: false));
    }
  }

  showOrder (order,listId){
    countDownAcceptOrder.value=20;
    timerAcceptOrder?.cancel();
    timerAcceptOrder=Timer.periodic(const Duration(seconds: 1), (timer) async{
      if(countDownAcceptOrder.value>0){
        countDownAcceptOrder.value--;
      }
      else{
        rejectOrder(order,listId);
        timer?.cancel();
      }
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (context, StateSetter setStateIn){
              return AlertDialog(
                title: const Text('Đơn hàng mới', textAlign: TextAlign.center,),
                content: Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.carTunnel, color: global.gold, size: 100),
                      Text('Bạn có một đơn hàng mới', style: TextStyle(color: global.black,fontWeight: FontWeight.bold,fontSize: 16)),
                      RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(text: 'Từ: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                              TextSpan(text: order['address_from'], style: const TextStyle(fontSize: 16, color: Colors.black))
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(text: 'Đến: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                              TextSpan(text: order['address_to'], style: const TextStyle(fontSize: 16, color: Colors.black))
                            ]
                        ),
                      ),
                      Expanded(child: Container(),),
                      ValueListenableBuilder(
                        valueListenable: countDownAcceptOrder,
                        builder: (context, error, child){
                          return Text('Bạn còn ${countDownAcceptOrder.value} giây để nhận đơn', style: TextStyle(color: global.black,fontWeight: FontWeight.bold,fontSize: 16));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Expanded(
                              flex:1,
                              child: InkWell(
                                onTap: () {
                                  rejectOrder(order,listId);
                                },
                                child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Huỷ đơn', textAlign: TextAlign.center,style: TextStyle(color: global.gold, fontWeight: FontWeight.bold,fontSize: 16),),
                                    )
                                ),
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: (){
                                  acceptOrder(order);
                                },
                                child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    decoration: BoxDecoration(
                                        color: global.gold,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Nhận đơn', style: TextStyle(color: global.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                    )
                                ),
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  sendLocation() async{
    timerOrder?.cancel();
    timerOrder=Timer.periodic(const Duration(seconds: 2), (timer) async{
      if(global.currentOrder!=null){
        LocationData myL=await location.getLocation();
        socket.emit('driverLocation',{'lat':myL.latitude,'long':myL.longitude,'order_id':global.currentOrder['id']});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageStorage(
              bucket: bucket,
              child: currentView,
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: global.black
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: itemBottomBar(() {
                    currentView=const HomeView();
                    currentTab=0;
                    setState(() {

                    });
                  }, FontAwesomeIcons.house, 'Trang chủ', currentTab==0),
                ),
                Expanded(
                  flex: 1,
                  child: itemBottomBar(() {
                    currentView=const OrderView();
                    currentTab=1;
                    setState(() {

                    });
                  }, FontAwesomeIcons.fileLines, 'Đơn hàng', currentTab==1),
                ),
                Expanded(
                  flex: 1,
                  child: itemBottomBar(() {
                    currentView=const WalletView();
                    currentTab=2;
                    setState(() {

                    });
                  }, FontAwesomeIcons.wallet, 'Ví', currentTab==2),
                ),
                Expanded(
                  flex: 1,
                  child: itemBottomBar(() {
                    currentView= const NotificationView();
                    currentTab=3;
                    setState(() {

                    });
                  }, FontAwesomeIcons.bell, 'Thông báo', currentTab==3),
                ),
                Expanded(
                  flex: 1,
                  child: itemBottomBar(() {
                    currentView=const AccountView();
                    currentTab=4;
                    setState(() {

                    });
                  }, FontAwesomeIcons.circleUser, 'Tài khoản', currentTab==4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
