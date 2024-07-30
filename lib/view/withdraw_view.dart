import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class WithdawView extends StatefulWidget {
  const WithdawView({super.key});

  @override
  State<WithdawView> createState() => _WithdawViewState();
}

class _WithdawViewState extends State<WithdawView> {

  //var
  AuthController authController=Get.find();
  WalletController walletController=Get.find();
  TextEditingController balanceController=TextEditingController();
  TextEditingController ten_ngan_hangController=TextEditingController();
  TextEditingController ten_chu_tai_khoanController=TextEditingController();
  TextEditingController so_tai_khoanController=TextEditingController();
  TextEditingController so_xu_can_rutController=TextEditingController();

  var numberFormat=NumberFormat('#,###','en_US');
  //method
  @override
  void initState() {
    super.initState();
    getData();
    ten_ngan_hangController.text=global.user['ten_ngan_hang'];
    ten_chu_tai_khoanController.text=global.user['chu_tai_khoan'];
    so_tai_khoanController.text=global.user['so_tai_khoan'];
  }

  getData()async{
    dynamic data=await walletController.getWallet(1/1/2023,1/1/2024);

    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      balanceController.text=numberFormat.format(data['data']['balance']);
    }
    setState(() {

    });
  }

  withdraw() async {
    if (so_xu_can_rutController.text.isEmpty) {
      global.showError('Vui lòng nhập số xu cần rút');
    }
    else {
      global.showLoading();
      dynamic data = await walletController.postWithdraw(so_xu_can_rutController.text);
      global.hideLoading();
      if (data['error'] == true) {
        global.showError(data['message']);
      }
      else {
        global.showSuccess(data['message']);
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Rút xu',style: TextStyle(color: global.gold),),
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
        //
        child: Column(
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
                child: ListView(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text('Số dư hiện tại', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            controller: balanceController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: global.black1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.black1
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.gold
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 2, 2, 2)
                            ),
                            cursorColor:global.gold,
                            style: TextStyle(color: global.gold, fontSize: 16),
                            obscureText: false,
                            readOnly: true,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text('Tên ngân hàng', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            controller: ten_ngan_hangController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: global.black1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.black1
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.gold
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 2, 2, 2)
                            ),
                            cursorColor:global.gold,
                            style: TextStyle(color: global.gold, fontSize: 16),
                            obscureText: false,
                            readOnly: true,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text('Tên chủ tài khoản', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            controller: ten_chu_tai_khoanController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: global.black1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.black1
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.gold
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 2, 2, 2)
                            ),
                            cursorColor:global.gold,
                            style: TextStyle(color: global.gold, fontSize: 16),
                            obscureText: false,
                            readOnly: true,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text('Số tài khoản', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            controller: so_tai_khoanController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: global.black1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.black1
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.gold
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 2, 2, 2)
                            ),
                            cursorColor:global.gold,
                            style: TextStyle(color: global.gold, fontSize: 16),
                            obscureText: false,
                            readOnly: true,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text('Số xu cần rút', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: TextField(
                            controller: so_xu_can_rutController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: global.black1,
                                hintText: 'Nhập số xu cần rút',
                                hintStyle: TextStyle(color: global.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.black1
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: global.gold
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 2, 2, 2)
                            ),
                            cursorColor:global.gold,
                            style: TextStyle(color: global.gold, fontSize: 16),
                            obscureText: false,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            withdraw();
                          },
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color:global.gold,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Center(
                                child: Text('Rút xu', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              )
                          ),
                        )
                      ],
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
        )
      ),
    );
  }
}
