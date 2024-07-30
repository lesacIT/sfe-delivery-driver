import 'package:deliverydriver/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;

class DetailNotificationView extends StatefulWidget {
  dynamic notify;
  DetailNotificationView({super.key, required this.notify});

  @override
  State<DetailNotificationView> createState() => _DetailNotificationViewState(notify);
}

class _DetailNotificationViewState extends State<DetailNotificationView> {
  dynamic notify;
  _DetailNotificationViewState(this.notify);
  //
  NotificationController notificationController=Get.find();

  @override
  void initState(){
    super.initState();
    chitietthongbaomoi();
  }

  chitietthongbaomoi() async{
    dynamic data=await notificationController.postMarkAsRead(notify['id']);
    if(data['error']==true){
      global.showError(data['message']);
    }
    else{

    }
    setState(() {

    });
  }
  

  String getTime(DateTime datetime, {bool full = false}) {
    DateTime now = DateTime.now();
    DateTime ago = datetime;
    Duration dur = now.difference(ago);
    int days = dur.inDays;
    int years = (days / 365).toInt();
    int months =  ((days - (years * 365)) / 30).toInt();
    int weeks = ((days - (years * 365 + months * 30)) / 7).toInt();
    int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
    int hours = (dur.inHours % 24).toInt();
    int minutes = (dur.inMinutes % 60).toInt();
    int seconds = (dur.inSeconds % 60).toInt();
    var diff = {
      "d":rdays,
      "w":weeks,
      "m":months,
      "y":years,
      "s":seconds,
      "i":minutes,
      "h":hours
    };
    Map str = {
      'y':'năm',
      'm':'tháng',
      'w':'tuần',
      'd':'ngày',
      'h':'giờ',
      'i':'phút',
      's':'giây',
    };

    str.forEach((k, v){
      if (diff[k]! > 0) {
        str[k] = diff[k].toString()  +  ' ' + v.toString() +  (diff[k]! > 1 ? '' : '');
      } else {
        str[k] = "";
      }
    });
    str.removeWhere((index, ele)=>ele == "");
    List<String> tlist = [];
    str.forEach((k, v){
      tlist.add(v);
    });
    if(full){
      return str.length > 0?tlist.join(", ") + " trước":"Just Now";
    }else{
      return str.length > 0?tlist[0] + " trước":"Just Now";
    }
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Chi tiết thông báo',style: TextStyle(color: global.gold),),
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
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: global.gold,
                                width: 1
                            )
                        ),
                        //color: Colors.white.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      //margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notify['title'],style: TextStyle(color: global.gold, fontWeight: FontWeight.bold,fontSize: 16),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.clock, color: global.gold,size: 18,),
                              Text(' '+getTime(DateTime.parse(notify['created_at'])),style: TextStyle(color: global.gold, fontSize: 16),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          children: [
                            Text(notify['content'],style: TextStyle(color: global.gold, fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
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
