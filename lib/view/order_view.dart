import 'package:deliverydriver/controller/order_controller.dart';
import 'package:deliverydriver/view/detail_order_view.dart';
import 'package:deliverydriver/view/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:intl/intl.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();

}

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin{
  //var
  late TabController tabController;
  OrderController orderController=Get.find();
  List listOrderPickingCustomer=[];
  List listOrderMoving=[];
  List listOrderCompleted=[];
  var numberFormat=NumberFormat();

  //method
  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      changeTab(tabController.index);
    });
    getData();
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

  getData()async{
    dynamic data=await orderController.getOrder('picking_customer');
    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      listOrderPickingCustomer=data['data'];
    }
    if(mounted){
      setState(() {

      });
    }
  }

  changeTab(index) async {
    if (index == 0) {
      dynamic data = await orderController.getOrder('picking_customer');
      listOrderPickingCustomer = data['data'];
      setState(() {

      });
    }
    else if (index == 1) {
      dynamic data = await orderController.getOrder('moving');
      listOrderMoving = data['data'];
      setState(() {

      });
    }
    else if (index == 2) {
      dynamic data = await orderController.getOrder('completed');
      listOrderCompleted = data['data'];
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Đơn hàng',style: TextStyle(color: global.gold),),
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                    TabBar(
                      controller: tabController,
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      labelStyle: TextStyle(fontSize: 16, color: global.gold),
                      indicatorColor: global.gold,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: global.grey,
                      tabs: const [
                        Tab(text: 'Đơn hàng mới',),
                        Tab(text: 'Đang chạy',),
                        Tab(text: 'Hoàn thành',),
                      ],
                      onTap: (index){
                        changeTab(index);
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Container(
                            child: ListView(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: List.generate(listOrderPickingCustomer.length, (index) {
                                  return InkWell(
                                    onTap: () async{
                                      await Get.to(()=>DetailOrderView(order: listOrderPickingCustomer[index], check: false));
                                      getData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(

                                          color: global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                                  Text(listOrderPickingCustomer[index]['distance'].toString()+' km', style: TextStyle(color: global.gold, fontSize: 16),),
                                                  Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listOrderPickingCustomer[index]['created_at'])), style: TextStyle(color: global.gold, fontSize: 16))
                                                ],
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: 'Điểm xuất phát: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                                    TextSpan(text: listOrderPickingCustomer[index]['address_from'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                    TextSpan(text: listOrderPickingCustomer[index]['address_to'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: getCTTenXe(listOrderPickingCustomer[index]['car_type'].toString()), style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: numberFormat.format(listOrderPickingCustomer[index]['total']), style: TextStyle(color: global.gold, fontSize: 16))
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ),
                                  );
                                })
                            ),
                          ),
                          Container(
                            child: ListView(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: List.generate(listOrderMoving.length, (index) {
                                  return InkWell(
                                    onTap: () async{
                                      await Get.to(()=>DetailOrderView(order: listOrderMoving[index], check: false));
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                                  Text(listOrderMoving[index]['distance'].toString()+' km', style: TextStyle(color: global.gold, fontSize: 16),),
                                                  Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listOrderMoving[index]['created_at'])), style: TextStyle(color: global.gold, fontSize: 16))
                                                ],
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: 'Điểm xuất phát: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                                    TextSpan(text: listOrderMoving[index]['address_from'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                    TextSpan(text: listOrderMoving[index]['address_to'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: getCTTenXe(listOrderMoving[index]['car_type'].toString()), style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: numberFormat.format(listOrderMoving[index]['total']), style: TextStyle(color: global.gold, fontSize: 16))
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ),
                                  );
                                })
                            ),
                          ),
                          Container(
                            child: ListView(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                children: List.generate(listOrderCompleted.length, (index) {
                                  return InkWell(
                                    onTap: (){
                                      Get.to(()=>DetailOrderView(order: listOrderCompleted[index], check: false));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                                  Text(listOrderCompleted[index]['distance'].toString()+' km', style: TextStyle(color: global.gold, fontSize: 16),),
                                                  Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listOrderCompleted[index]['created_at'])), style: TextStyle(color: global.gold, fontSize: 16))
                                                ],
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: 'Điểm xuất phát: ', style: TextStyle(fontWeight:FontWeight.bold,color: global.gold, fontSize: 16)),
                                                    TextSpan(text: listOrderCompleted[index]['address_from'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                    TextSpan(text: listOrderCompleted[index]['address_to'], style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: getCTTenXe(listOrderCompleted[index]['car_type'].toString()), style: TextStyle(color: global.gold, fontSize: 16))
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
                                                        TextSpan(text: numberFormat.format(listOrderCompleted[index]['total']), style: TextStyle(color: global.gold, fontSize: 16))
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ),
                                  );
                                })
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
        )
      ),
    );
  }
}
