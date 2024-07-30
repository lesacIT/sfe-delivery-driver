import 'dart:typed_data';

import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
class TopupView extends StatefulWidget {
  const TopupView({super.key});

  @override
  State<TopupView> createState() => _TopupViewState();
}

class _TopupViewState extends State<TopupView> {

  //var
  String qrCode='';
  AuthController authController=Get.find();
  //method
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Nạp xu',style: TextStyle(color: global.gold),),
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
        //padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: global.black1,
                              ),
                              clipBehavior: Clip.antiAlias,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              //margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Image.network('https://api.vietqr.io/image/970454-8007041094268-IDH0xts.jpg?accountName=PHAM%20GIA%20MINH&amount=0&addInfo=NAPHK%20${global.user['phone']}', fit: BoxFit.fill,)
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async{
                                global.showLoading();
                                var response = await Dio().get(
                                    'https://api.vietqr.io/image/970454-8007041094268-IDH0xts.jpg?accountName=PHAM%20GIA%20MINH&amount=0&addInfo=NAPHK%20${global.user['phone']}',
                                    options: Options(responseType: ResponseType.bytes));
                                final result = await ImageGallerySaver.saveImage(
                                    Uint8List.fromList(response.data),
                                    quality: 60,
                                    name: "qr_image"
                                );
                                global.hideLoading();
                                global.showSuccess('Đã tải xuống thành công');
                              },
                              child: Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: global.gold,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text('Tải ảnh xuống', style: TextStyle(fontSize: 16, color: global.black, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Quét mã QR hoặc chuyển tiền theo thông tin bên dưới (hệ thống sẽ tự động cộng xu sau 5 phút)', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: global.gold),)
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Ngân hàng', style: TextStyle(fontSize: 16, color: Colors.grey),)
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: global.black1,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('Ngân hàng Bản Việt (BVBank)', style: TextStyle(fontSize: 16, color: global.gold),),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Số tài khoản', style: TextStyle(fontSize: 16, color: Colors.grey),)
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: global.black1,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('8007041094268', style: TextStyle(fontSize: 16, color: global.gold),),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Chủ tài khoản', style: TextStyle(fontSize: 16, color: Colors.grey),)
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: global.black1,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('PHẠM GIA MINH', style: TextStyle(fontSize: 16, color: global.gold),),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Nội dung', style: TextStyle(fontSize: 16, color: Colors.grey),)
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: global.black1,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('NAPHK ${global.user['phone']}', style: TextStyle(fontSize: 16, color: global.gold),),
                          )
                      )
                    ],
                  )
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
