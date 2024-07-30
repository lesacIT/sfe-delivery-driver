import 'package:deliverydriver/controller/notification_controller.dart';
import 'package:deliverydriver/view/detail_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:intl/intl.dart';
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  //var
  NotificationController notificationController=Get.find();
  List listNotification=[];

  //method
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    dynamic data=await notificationController.getNotification();
    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      listNotification=data['data'];
    }
    if(mounted){
      setState(() {

      });
    }
  }

 DanhDauDaDocTatCa() async{
    //goi api danh dau
    dynamic data=await notificationController.postMarkAsReadAll();
    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Thông báo',style: TextStyle(color: global.gold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(global.backgroundImage1),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
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
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      //margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Thông báo mới',style: TextStyle(color: global.gold, fontWeight: FontWeight.bold,fontSize: 16),),
                          InkWell(
                            onTap: (){
                              DanhDauDaDocTatCa();
                            },
                            child: Text('Đánh dấu đã đọc',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 16),),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        children: List.generate(listNotification.length, (index){
                          return InkWell(
                            onTap: ()async{
                              await Get.to(()=>DetailNotificationView(notify: listNotification[index]));
                              getData();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: listNotification[index]['status']=='unread'?global.gold:Colors.transparent,
                                      width: 1
                                  ),
                                  color: global.black1,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.notification_important_outlined,color: Colors.red,size: 25,),
                                      Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listNotification[index]['created_at'])), style: TextStyle(color: global.gold,fontSize: 16),),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(listNotification[index]['title'], style: TextStyle(color: global.gold, fontSize: 16),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(listNotification[index]['content'], style: TextStyle(color:global.gold, fontSize: 16),),
                                  )
                                ],
                              ),

                            ),
                          );
                        }),
                      ),
                    )
                  ],
                )
            ),
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
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
