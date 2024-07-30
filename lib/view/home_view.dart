import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/home_controller.dart';
import 'package:deliverydriver/controller/order_controller.dart';
import 'package:deliverydriver/view/detail_order_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //var
  AuthController authController=Get.find();
  OrderController orderController=Get.find();
  HomeController homeController=Get.find();
  var numberFormat=NumberFormat();
  int order=0;
  int revenue=0;
  List listCheckCurrentOrder=[];

  //method
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    global.showLoading();
    dynamic data=await homeController.getHome();
    if(!data['error']){
      if(data['data']['status']=='online'){
        global.statusOnline=true;
      }
      else{
        global.statusOnline=false;
      }
      listCheckCurrentOrder=data['data']['orders'];
      if(listCheckCurrentOrder.isNotEmpty){
        global.currentOrder=listCheckCurrentOrder[0];
      }
    }
    global.hideLoading();
    setState(() {

    });
  }

  String getTrangThai(status){
    String result='';
    if(status=='waiting_driver'){
      result='Chờ tài xế xác nhận';
    }
    else if(status=='picking_customer'){
      result='Đang đón khách';
    }
    else if(status=='moving'){
      result='Đang di chuyển';
    }
    else if(status=='completed'){
      result='Hoàn thành';
    }
    else if( status=='canceled'){
      result='Huỷ';
    }
    return result;
  }

  changeStatus() async {
    dynamic data = await authController.postChangeStatus(global.statusOnline==true?'offline':'online');
    if (data['error'] == true) {
      global.showError(data['message']);
    }
    else {
      global.showSuccess(data['message']);
      global.statusOnline=!global.statusOnline;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(global.backgroundImage1),
              fit: BoxFit.fill
          )
        ),
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).viewPadding.top, 0, 0),
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
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: global.statusOnline==false?global.black:global.gold,
                          borderRadius: BorderRadius.circular(0)
                      ),
                      //padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(global.statusOnline)
                            Text('ONLINE', style: TextStyle(fontSize: 20,color: global.black,fontWeight: FontWeight.bold),)
                          else
                            Text('OFFLINE', style: TextStyle(fontSize: 20,color: global.grey,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: global.statusOnline?global.grey.withOpacity(0):Color.fromRGBO(143, 142, 139, 1)
                          ),
                          // padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(

                                    color: global.black1,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(global.link+'/'+global.user['anh_chan_dung'],fit: BoxFit.fill),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(global.user['name'],style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 20, fontWeight: FontWeight.bold),),
                                                Text(global.user['hang_xe'], style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                                                Text(global.user['bien_so_xe'], style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16),)
                                              ],
                                            ),
                                            InkWell(
                                              onTap: (){
                                                changeStatus();
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 30,
                                                decoration: BoxDecoration(

                                                    color: Colors.grey.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                padding: EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment: global.statusOnline?MainAxisAlignment.end:MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: global.statusOnline?global.gold:global.black,
                                                          borderRadius: BorderRadius.circular(180)
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Container(
                              //
                              //   decoration: BoxDecoration(
                              //       color: global.black1,
                              //       borderRadius: BorderRadius.circular(10)
                              //   ),
                              //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              //   margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Tổng đơn hôm nay', style: TextStyle(color: global.gold,fontWeight: FontWeight.bold, fontSize: 16),),
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         crossAxisAlignment: CrossAxisAlignment.end,
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.start,
                              //             crossAxisAlignment: CrossAxisAlignment.end,
                              //             children: [
                              //               Text(order.toString(),style: TextStyle(color: global.gold,fontWeight: FontWeight.bold,fontSize: 30),),
                              //               Text('đơn',style: TextStyle(color: global.gold.withOpacity(0.5),fontSize: 16),),
                              //             ],
                              //           ),
                              //           // Row(
                              //           //   mainAxisAlignment: MainAxisAlignment.end,
                              //           //   crossAxisAlignment: CrossAxisAlignment.start,
                              //           //   children: [
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.userLarge,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.motorcycle,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.car,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     FaIcon(FontAwesomeIcons.chevronRight,color: global.gold,size: 18,)
                              //           //   ],
                              //           // )
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //
                              //   decoration: BoxDecoration(
                              //
                              //       color: global.black1,
                              //       borderRadius: BorderRadius.circular(10)
                              //   ),
                              //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              //   margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Doanh thu', style: TextStyle(color: global.gold,fontWeight: FontWeight.bold, fontSize: 16),),
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         crossAxisAlignment: CrossAxisAlignment.end,
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.start,
                              //             crossAxisAlignment: CrossAxisAlignment.end,
                              //             children: [
                              //               Text(numberFormat.format(revenue),style: TextStyle(color: global.gold,fontWeight: FontWeight.bold,fontSize: 30),),
                              //
                              //             ],
                              //           ),
                              //           // Row(
                              //           //   mainAxisAlignment: MainAxisAlignment.end,
                              //           //   crossAxisAlignment: CrossAxisAlignment.start,
                              //           //   children: [
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.userLarge,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.motorcycle,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              //           //       child: FaIcon(FontAwesomeIcons.car,color: global.gold,size: 18,),
                              //           //     ),
                              //           //     Padding(
                              //           //       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              //           //       child: Text('0',style: TextStyle(color: global.gold,fontSize: 16),),
                              //           //     ),
                              //           //     FaIcon(FontAwesomeIcons.chevronRight,color: global.gold,size: 18,)
                              //           //   ],
                              //           // )
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                decoration: BoxDecoration(
                                    color: global.black1,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: InkWell(
                                  onTap: (){
                                    //Get.to(()=>DeleteView());
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Hướng dẫn nạp xu', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold),),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Bước 1: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                            Text('Nhấn chọn ví', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Bước 2: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                            Text('Nhấn chọn nạp xu', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Bước 3: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                            Text('Quét mã QR', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Bước 4: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                            Expanded(
                                              child: Text('Nhập số tiền cần nạp ở app ngân hàng sau đó chuyển khoản', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(listCheckCurrentOrder.length, (index){
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: global.black1,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.locationDot, color: global.gold,),
                                              Text(' ${getTrangThai(listCheckCurrentOrder[index]['status'])}', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: 'Từ: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                                  TextSpan(text: listCheckCurrentOrder[index]['address_from'], style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16))
                                                ]
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: 'Đến: ', style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16, fontWeight: FontWeight.bold)),
                                                  TextSpan(text: listCheckCurrentOrder[index]['address_to'], style: TextStyle(color: global.statusOnline?global.gold:global.grey,fontSize: 16))
                                                ]
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: global.gold,
                                          ),
                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Get.to(()=>DetailOrderView(order: listCheckCurrentOrder[index], check: false));
                                                },
                                                child: Text('Tiếp tục hành trình',style: TextStyle(fontWeight: FontWeight.bold, color: global.black, fontSize: 16),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )

                            ],
                          ),
                        )
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
