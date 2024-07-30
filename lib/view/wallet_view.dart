import 'package:deliverydriver/controller/wallet_controller.dart';
import 'package:deliverydriver/view/topup_view.dart';
import 'package:deliverydriver/view/withdraw_request_view.dart';
import 'package:deliverydriver/view/withdraw_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:intl/intl.dart';
class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  //var

  int money= 400000000;
  bool showMoney= false;
  TextEditingController fromController=TextEditingController();
  TextEditingController toController=TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime fromDateTime = DateTime.now();
  DateTime toDateTime = DateTime.now();


  //var load data
  WalletController walletController=Get.find();
  List listWallet=[];
  var numberFormat=NumberFormat('#,###','en_US');

  //method
  @override
  void initState() {
    super.initState();
    fromController.text=DateFormat('dd/MM/yyyy') .format(fromDateTime);
    toController.text=DateFormat('dd/MM/yyyy').format(toDateTime);
    getData();
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        locale: Get.locale
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }
    return selectedDate;
  }

  Future selectFromDate(BuildContext context) async {
    final date = await selectDate(context);
    fromDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      0,
      0,
    );
    fromController.text=DateFormat('dd/MM/yyyy') .format(fromDateTime);
    getData();
  }

  Future selectoDate(BuildContext context) async {
    final date = await selectDate(context);
    toDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      0,
      0,
    );
    toController.text=DateFormat('dd/MM/yyyy').format(toDateTime);
    getData();
  }

  //method load
  getData() async{
    dynamic data=await walletController.getWallet(DateFormat('yyyy-MM-dd').format(fromDateTime),DateFormat('yyyy-MM-dd').format(toDateTime));

    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      listWallet=data['data']['list'];
      money=data['data']['balance'];
    }
    if(mounted){
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Ví',style: TextStyle(color: global.gold),),
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
        //padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(

                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: global.black1,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        //margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.wallet,color: global.gold,size: 30,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Số xu hiện tại',style: TextStyle(color: global.gold,fontSize: 16),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text((showMoney==true?numberFormat.format(money):'******')+' ', style: TextStyle(color: global.gold,fontWeight: FontWeight.bold,fontSize: 16),),
                                            if (showMoney==true)
                                              Container(
                                                width: 18,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: global.gold,
                                                      width: 1
                                                  ),
                                                  color: global.gold.withOpacity(0.7),
                                                  borderRadius: BorderRadius.circular(18),
                                                ),

                                                padding: const EdgeInsets.all(2),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.asset('assets/logo2.png',fit: BoxFit.fill,),
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: (){
                                        showMoney=!showMoney;
                                        setState(() {

                                        });
                                      },
                                      child: FaIcon(showMoney==false?FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash,size: 18,color: global.gold),

                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex:1,

                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=>const TopupView());
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      decoration: BoxDecoration(
                                          color:global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FaIcon(FontAwesomeIcons.moneyBillWave,color: global.gold,),
                                          Text('Nạp xu', style: TextStyle(color: global.gold,fontSize: 16),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=>const WithdawView());
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                          color: global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FaIcon(FontAwesomeIcons.moneyBillTrendUp,color: global.gold,),
                                          Text('Rút xu', style: TextStyle(color: global.gold,fontSize: 16),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=>const WithdrawRequestView());
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      decoration: BoxDecoration(
                                          color: global.black1,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FaIcon(FontAwesomeIcons.moneyBillTransfer,color: global.gold,),
                                          Text('Lệnh rút xu', style: TextStyle(color: global.gold,fontSize: 16),),
                                        ],
                                      )
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: global.black1,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lịch sử thay đổi số dư', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex:1,

                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: InkWell(
                                          onTap: (){

                                          },
                                          child: TextField(
                                            controller: fromController,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: global.black1,
                                                hintText: 'Từ ngày',
                                                hintStyle: TextStyle(color: global.grey),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: global.gold
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: global.gold),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                                                suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color: global.gold)
                                            ),
                                            cursorColor: global.grey,
                                            style: TextStyle(color: global.grey),
                                            obscureText: false,
                                            readOnly: true,
                                            onTap: (){
                                              selectFromDate(context);
                                            },
                                          ),
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: InkWell(
                                          onTap: (){

                                          },
                                          child: TextField(
                                            controller: toController,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: global.black1,
                                                hintText: 'Đến ngày',
                                                hintStyle: TextStyle(color: global.grey),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: global.gold
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: global.gold
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                                                suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color: global.gold,)
                                            ),
                                            cursorColor: global.grey,
                                            style: TextStyle(color: global.grey),
                                            obscureText: false,
                                            readOnly: true,
                                            onTap: (){
                                              selectoDate(context);
                                            },
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            shrinkWrap: true,
                            children: List.generate(listWallet.length, (index){
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: global.black,
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color:  global.black1,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.library_books,color:  global.gold),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                        child: Text(listWallet[index]['note'],style: TextStyle(color:  global.gold, fontWeight: FontWeight.bold,fontSize: 16),),
                                                      ),
                                                      Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listWallet[index]['created_at'])), style: TextStyle(fontSize: 16, color:  global.gold.withOpacity(0.8)),)
                                                    ],
                                                  ),
                                                  Text(numberFormat.format(listWallet[index]['amount']), style: TextStyle(color: global.gold,fontWeight: FontWeight.bold,fontSize: 16),)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        ),
                      )
                    ],
                  ),
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
