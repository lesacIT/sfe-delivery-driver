import 'dart:io';

import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/shared_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:image_picker/image_picker.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //var
  SharedController sharedController=Get.find();
  List loaiDVSelected=[];
  List listLDV=[
    {'id':'tai_4_cho','name':'Tài xế 4 chỗ'},
    {'id':'tai_7_cho','name':'Tài xế 7 chỗ'},
    {'id':'tai_xe_may','name':'Tài xế xe máy'},
    {'id':'xe_om','name':'Xe ôm'},
  ];
  String? BankSelected;
  List listBank=[];

  XFile? avatar;
  XFile? cccdmattruoc;
  XFile? cccdmatsau;
  XFile? gplxmattruoc;
  XFile? gplxmatsau;
  XFile? gtxmattruoc;
  XFile? gtxmatsau;

  final ImagePicker imagePicker = ImagePicker();

  //var load data
  AuthController authController=Get.find();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirm_passwordController=TextEditingController();
  TextEditingController phone_zaloController=TextEditingController();
  TextEditingController ma_giam_satController=TextEditingController();
  TextEditingController anh_chan_dungController=TextEditingController();
  TextEditingController cccdController=TextEditingController();
  TextEditingController anh_mat_truoc_cccdController=TextEditingController();
  TextEditingController anh_mat_sau_cccdController=TextEditingController();
  TextEditingController loai_dich_vuController=TextEditingController();
  TextEditingController bien_so_xeController=TextEditingController();
  TextEditingController hang_xeController=TextEditingController();
  TextEditingController mat_truoc_gplxController=TextEditingController();
  TextEditingController mat_sau_gplxController=TextEditingController();
  TextEditingController mat_truoc_giay_to_xeController=TextEditingController();
  TextEditingController mat_sau_giay_to_xeController=TextEditingController();
  TextEditingController ten_ngan_hangController=TextEditingController();
  TextEditingController ten_chu_tai_khoanController=TextEditingController();
  TextEditingController so_tai_khoanController=TextEditingController();

  //method
  @override
  void initState() {
    super.initState();
    getBankList();
  }

  register() async {
    if (nameController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập họ và tên');
    }
    else if (phoneController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập số điện thoại');
    }
    else if (phoneController.text[0]!='0' || phoneController.text.length!=10) {
      global.showError(
          'Số điện thoại không đúng định dạng');
    }
    else if (passwordController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập mật khẩu');
    }
    else if (passwordController.text != confirm_passwordController.text) {
      global.showError('Nhập lại mật khẩu không chính xác');
    }
    else if (phone_zaloController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập số điện thoại zalo');
    }
    else if (phone_zaloController.text[0]!='0' || phone_zaloController.text.length!=10) {
      global.showError(
          'Số điện thoại zalo không đúng định dạng');
    }
    else if (cccdController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập số căn cước công dân');
    }
    else if (cccdController.text[0]!='0' || cccdController.text.length!=12) {
      global.showError(
          'Số căn cước công dân không đúng định dạng');
    }
    else if (cccdmattruoc==null) {
      global.showError(
          'Vui lòng chọn ảnh căn cước công dân mặt trước');
    }
    else if (cccdmatsau==null) {
      global.showError(
          'Vui lòng chọn ảnh căn cước công dân mặt sau');
    }
    else if (loaiDVSelected.isEmpty) {
      global.showError(
          'Vui lòng nhập chọn loại dịch vụ');
    }
    else if (bien_so_xeController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập biển số xe');
    }
    else if (hang_xeController.text.isEmpty) {
      global.showError(
          'Vui lòng nhập hãng xe');
    }
    else if (gplxmattruoc==null) {
      global.showError(
          'Vui lòng chọn ảnh giấy phép lái xe mặt trước');
    }
    else if (gplxmatsau==null) {
      global.showError(
          'Vui lòng chọn ảnh giấy phép lái xe mặt sau');
    }
    else {
      global.showLoading();
      String imageUrl1='';
      String imageUrl2='';
      String imageUrl3='';
      String imageUrl4='';
      String imageUrl5='';
      String imageUrl6='';
      String imageUrl7='';

      dynamic data1=await sharedController.postUploadImage(avatar!.path.toString());
      if(data1['error']==false) {
        imageUrl1 = data1['data'];
      }

      dynamic data2=await sharedController.postUploadImage(cccdmattruoc!.path.toString());
      if(data2['error']==false) {
        imageUrl2 = data2['data'];
      }

      dynamic data3=await sharedController.postUploadImage(cccdmatsau!.path.toString());
      if(data3['error']==false) {
        imageUrl3 = data3['data'];
      }

      dynamic data4=await sharedController.postUploadImage(gplxmattruoc!.path.toString());
      if(data4['error']==false) {
        imageUrl4 = data4['data'];
      }

      dynamic data5=await sharedController.postUploadImage(gplxmatsau!.path.toString());
      if(data5['error']==false) {
        imageUrl5 = data5['data'];
      }

      if(gtxmattruoc!=null){
        dynamic data6=await sharedController.postUploadImage(gtxmattruoc!.path.toString());
        if(data6['error']==false) {
          imageUrl6 = data6['data'];
        }
      }

      if(gtxmatsau!=null){
        dynamic data7=await sharedController.postUploadImage(gtxmatsau!.path.toString());
        if(data7['error']==false) {
          imageUrl7 = data7['data'];
        }
      }

      dynamic data = await authController.postRegister(
          nameController.text,
          phoneController.text,
          passwordController.text,
          phone_zaloController.text,
          ma_giam_satController.text,
          imageUrl1,
          cccdController.text,
          imageUrl2,
          imageUrl3,
          loaiDVSelected.join(','),
          bien_so_xeController.text,
          hang_xeController.text,
          imageUrl4,
          imageUrl5,
          imageUrl6,
          imageUrl7,
          ten_ngan_hangController.text,
          ten_chu_tai_khoanController.text,
          so_tai_khoanController.text
      );
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

  Future<void> pickAvatar(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    avatar=pickedFile;
    setState(() {

    });
  }

  Future<void> pickCccdmattruoc(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    cccdmattruoc=pickedFile;
    setState(() {

    });
  }

  Future<void> pickCccdmatsau(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    cccdmatsau=pickedFile;
    setState(() {

    });
  }

  Future<void> pickGplxmattruoc(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    gplxmattruoc=pickedFile;
    setState(() {

    });
  }

  Future<void> pickGplxmatsau(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    gplxmatsau=pickedFile;
    setState(() {

    });
  }

  Future<void> pickGtxmattruoc(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    gtxmattruoc=pickedFile;
    setState(() {

    });
  }

  Future<void> pickGtxmatsau(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    gtxmatsau=pickedFile;
    setState(() {

    });
  }

  getAvatar(){
    File image=File(avatar!.path.toString());
    return image;
  }

  getCccdmattruoc(){
    File image=File(cccdmattruoc!.path.toString());
    return image;
  }

  getCccdmatsau(){
    File image=File(cccdmatsau!.path.toString());
    return image;
  }

  getGplxmattruoc(){
    File image=File(gplxmattruoc!.path.toString());
    return image;
  }

  getGplxmatsau(){
    File image=File(gplxmatsau!.path.toString());
    return image;
  }

  getGtxmattruoc(){
    File image=File(gtxmattruoc!.path.toString());
    return image;
  }

  getGtxmatsau(){
    File image=File(gtxmatsau!.path.toString());
    return image;
  }

  getNameLDV(){
    List nameList=[];
    for(int i=0;i<loaiDVSelected.length;i++){
      for(int j=0;j<listLDV.length;j++){
        if(loaiDVSelected[i].toString().trim()==listLDV[j]['id']){
          nameList.add(listLDV[j]['name']);
          break;
        }
      }
    }
    return nameList.join(', ');
  }


  getBankList() async{
    listBank=await authController.getBankList();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Đăng ký tài khoản',style: TextStyle(color: global.gold, fontSize: 25,fontWeight: FontWeight.bold),),
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(global.backgroundImage1),
              fit: BoxFit.fill
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text('THÔNG TIN ĐĂNG NHẬP', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text('Ảnh chân dung', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickAvatar(ImageSource.gallery);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: avatar!=null?Image.file(getAvatar(), fit: BoxFit.fill,):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Họ & tên', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: global.black1,
                  hintText: 'Nguyễn Văn A',
                  hintStyle: TextStyle(color: global.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.black1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số điện thoại', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: global.black1,
                  hintText: 'VD: 0776301209',
                  hintStyle: TextStyle(color: global.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.black1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mật Khẩu', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: passwordController,
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
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nhập lại mật khẩu', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: confirm_passwordController,
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
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số điện thoại Zalo', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: phone_zaloController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: global.black1,
                  hintText: 'VD: 0776301209',
                  hintStyle: TextStyle(color: global.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.black1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã giám sát', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: ma_giam_satController,
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
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,

            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Text('THÔNG TIN GIẤY TỜ TUỲ THÂN', style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số CMND/ CCCD', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: cccdController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Nhập số CMND/CCCD',
                  hintStyle: TextStyle(color: global.grey),
                  fillColor: global.black1,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.black1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CMND/CCCD mặt trước', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickCccdmattruoc(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: cccdmattruoc!=null?Image.file(getCccdmattruoc(), fit: BoxFit.fill,):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CMND/CCCD mặt sau', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickCccdmatsau(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: cccdmatsau!=null?Image.file(getCccdmatsau(), fit: BoxFit.fill):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Text('THÔNG TIN GIẤY TỜ XE', style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loại dịch vụ', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              child: TextField(
                controller: loai_dich_vuController,
                decoration: InputDecoration(
                    filled: true,
                    hintText: 'Chọn dịch vụ bạn muốn đăng ký',
                    hintStyle: TextStyle(color: global.grey),
                    fillColor: global.black1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: global.black1
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: global.grey
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
                ),
                cursorColor: global.grey,
                style: TextStyle(color: global.grey),
                readOnly: true,
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return StatefulBuilder(
                        builder: (context, StateSetter setStateIn){
                          return AlertDialog(
                            backgroundColor: global.black,
                            title: const Text('Chọn dịch vụ', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),
                            content: Container(
                              height: 180,
                              child: Column(
                                children: [
                                  for(int index=0;index<listLDV.length;index++)
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(listLDV[index]['name'], style: TextStyle(color: Colors.grey, fontSize: 16),),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              if(!loaiDVSelected.contains(listLDV[index]['id'])){
                                                loaiDVSelected.add(listLDV[index]['id']);
                                              }
                                              else{
                                                loaiDVSelected.remove(listLDV[index]['id']);
                                              }
                                              loai_dich_vuController.text=getNameLDV();
                                              setStateIn((){});
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey
                                                )
                                              ),
                                              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                              child: loaiDVSelected.contains(listLDV[index]['id'])?Center(child:Icon(Icons.check, color: global.gold, size: 22,)):Text(''),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  );
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Biển số xe', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: bien_so_xeController,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Nhập biển số xe',
                hintStyle: TextStyle(color: global.grey),
                fillColor: global.black1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.black1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.grey
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hãng xe', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextField(
              controller: hang_xeController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Nhập hãng xe',
                  hintStyle: TextStyle(color: global.grey),
                  fillColor: global.black1,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.black1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: global.grey
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giấy phép lái xe mặt trước', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickGplxmattruoc(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: gplxmattruoc!=null?Image.file(getGplxmattruoc(), fit: BoxFit.fill):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giấy phép lái xe mặt sau', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                  const Text('*', style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickGplxmatsau(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: gplxmatsau!=null?Image.file(getGplxmatsau(),fit: BoxFit.fill):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text('Giấy tờ xe mặt trước', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickGtxmattruoc(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: gtxmattruoc!=null?Image.file(getGtxmattruoc(), fit: BoxFit.fill):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text('Giấy tờ xe mặt sau', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickGtxmatsau(ImageSource.gallery);
                  },
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(

                        width: 1,
                        color: global.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: global.black1,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: gtxmatsau!=null?Image.file(getGplxmatsau(), fit: BoxFit.fill):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.add, size: 20,color: global.grey),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Upload',style: TextStyle(fontWeight: FontWeight.bold, color: global.grey, fontSize: 16),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
              child: Text('THÔNG TIN TÀI KHOẢN NGÂN HÀNG', style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text('Tên ngân hàng', style: TextStyle(color: global.gold, fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            TextField(
              controller: ten_ngan_hangController,
              decoration: InputDecoration(
                filled: true,
                fillColor: global.black1,
                hintText: 'Chọn tên ngân hàng',
                suffixIcon: Icon(Icons.arrow_drop_down, color: global.gold,),
                hintStyle: TextStyle(color: global.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.black1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.grey
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
              readOnly: true,
              onTap: (){
                showModalBottomSheet(
                    backgroundColor: global.black,
                    context: context,
                    builder: (context){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView(
                                children: List.generate(listBank.length, (index){
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: global.black
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            ten_ngan_hangController.text='${listBank[index]['shortName']} - ${listBank[index]['name']}';
                                            Get.back();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                      color: global.grey,
                                                      width: 0.2,
                                                    )
                                                ),
                                                borderRadius: BorderRadius.circular(0),
                                                color: global.black1
                                            ),
                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // width: 50,
                                                  // height: 50,
                                                  // decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.circular(10)
                                                  // ),
                                                  // clipBehavior: Clip.antiAlias,
                                                  // child: Image.network(listBank[index]['image'],fit: BoxFit.fill),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                    child: Text('${listBank[index]['shortName']} - ${listBank[index]['name']}',style: TextStyle(color: global.gold,fontSize: 16),),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                })
                            ),
                          )
                        ],
                      );
                    }
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text('Tên chủ tài khoản', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            TextField(
              controller: ten_chu_tai_khoanController,
              decoration: InputDecoration(
                filled: true,
                fillColor: global.black1,
                hintText: 'Nhập họ tên chủ tài khoản',
                hintStyle: TextStyle(color: global.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.black1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.grey
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text('Số tài khoản ngân hàng', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            TextField(
              controller: so_tai_khoanController,
              decoration: InputDecoration(
                filled: true,
                fillColor: global.black1,
                hintText: 'Nhập số tài khoản ngân hàng',
                hintStyle: TextStyle(color: global.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.black1
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: global.grey
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 2, 2, 2)
              ),
              cursorColor: global.grey,
              style: TextStyle(color: global.grey),
              obscureText: false,
            ),
            InkWell(
              onTap: (){
                register();
              },
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  color: global.gold,
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Đăng ký',style: TextStyle(fontWeight: FontWeight.bold, color: global.black, fontSize: 16),),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Bạn đã có tài khoản? ', style: TextStyle(fontSize: 16, color: global.gold),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Text(' Đăng nhập ngay', style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
