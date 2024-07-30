import 'package:deliverydriver/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';

class OrderDetailView extends StatefulWidget {
  //dynamic order;
  OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Chi tiết đơn hàng',style: TextStyle(color: global.gold),),
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
        // color: Colors.grey.withOpacity(0.1),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                color: global.black,
              ),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child:
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FaIcon(FontAwesomeIcons.locationDot, color: global.gold,),
                              Text(' GỬI HÀNG TẠI', style: TextStyle(fontSize: 20, color: global.gold),),
                            ],
                          ),
                        ),
                        Text('Tên hàng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  global.gold),),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: 'Địa chỉ: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                  TextSpan(text: 'Ngô Thì Nhậm, An Khánh, Ninh Kiều, Cần Thơ', style: TextStyle(color: global.gold.withOpacity(0.8), fontSize: 16))
                                ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: 'Chi tiết: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                  TextSpan(text: '124B, Ngô Thì Nhậm, An Khánh, Ninh Kiều, Cần Thơ', style: TextStyle(color: global.gold.withOpacity(0.8), fontSize: 16))
                                ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text('Cách bạn ?km', style: TextStyle(fontSize: 16, color: Colors.redAccent),),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
