import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;

class ChangPassWordView extends StatefulWidget {
  const ChangPassWordView({super.key});

  @override
  State<ChangPassWordView> createState() => _ChangPassWordViewState();
}

class _ChangPassWordViewState extends State<ChangPassWordView> {
  //var
  AuthController authController=Get.find();
  TextEditingController old_passwordController=TextEditingController();
  TextEditingController new_passwordController=TextEditingController();
  TextEditingController confirm_new_passwordController=TextEditingController();

  //method

  changepassword() async {
    if (
    old_passwordController.text.isEmpty) {
      global.showError('Vui lòng nhập mật khẩu cũ');
    }
    else if (new_passwordController.text.isEmpty) {
      global.showError('Vui lòng nhập mật khẩu mới');
    }
    else if (confirm_new_passwordController.text.isEmpty) {
      global.showError('Vui lòng nhập lại mật khẩu mới');
    }
    else if (new_passwordController.text != confirm_new_passwordController.text) {
      global.showError('Nhập lại mật khẩu không chính xác');
    }
    else {
      dynamic data = await authController.postChangePassword(
          old_passwordController.text, new_passwordController.text);
      if (data['error'] == true) {
        global.showError(data['message']);
      }
      else {
        global.showSuccess(data['message']);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Đổi mật khẩu',style: TextStyle(color: global.gold),),
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
        child:Column(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mật Khẩu hiện tại', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                                Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          TextField(
                            controller: old_passwordController,
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
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(15, 2, 2, 2)
                            ),
                            cursorColor: Colors.grey,
                            style: TextStyle(color: global.grey),
                            obscureText: true,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mật Khẩu mới', style: TextStyle(color: global.gold,fontSize: 16, fontWeight: FontWeight.bold),),
                                Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          TextField(
                            controller: new_passwordController,
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
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(15, 2, 2, 2)
                            ),
                            cursorColor: Colors.grey,
                            style: TextStyle(color: global.grey),
                            obscureText: true,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nhập lại mật Khẩu mới', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                                Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),

                          TextField(
                            controller: confirm_new_passwordController,
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
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(15, 2, 2, 2)
                            ),
                            cursorColor: Colors.grey,
                            style: TextStyle(color: global.grey),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex:1,
                            child: InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Container(
                                height: 45,
                                margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
                                decoration: BoxDecoration(

                                    color: global.black1,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text('Huỷ', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                changepassword();
                              },
                              child: Container(
                                  height: 45,
                                  margin: EdgeInsets.fromLTRB(10, 20, 20, 0),
                                  decoration: BoxDecoration(

                                      color: global.gold,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                    child: Text('Đổi mật khẩu', style: TextStyle(fontSize: 16, color: global.black,fontWeight: FontWeight.bold),),
                                  )

                              ),
                            )
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
        ),
      ),
    );
  }
}
