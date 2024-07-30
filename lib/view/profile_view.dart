import 'dart:io';

import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/shared_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:image_picker/image_picker.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  SharedController sharedController=Get.find();

  XFile? avatar;


  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickAvatar(ImageSource source, {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: source,
    );
    avatar=pickedFile;
    setState(() {

    });
  }

  String? tinhtpSelected;
  List listTinhTp=[
    {'slug':'can-tho','title':'Cần Thơ'},
    {'slug':'tien-giang','title':'Tiền Giang'},
  ];

  String? quanhuyenSelected;
  List listQH=[
    {'slug':'phong-dien','title':'Phong Điền'},
    {'slug':'cai-lay','title':'Cai Lậy'},
  ];

  String? phuongxaSelected;
  List listPX=[
    {'slug':'my-khach','title':'Mỹ Khách'},
    {'slug':'binh-phu','title':'Bình Phú'},
  ];


  AuthController authController=Get.find();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController phone_zaloController=TextEditingController();
  TextEditingController ma_giam_satController=TextEditingController();
  TextEditingController cccdController=TextEditingController();
  TextEditingController loai_dich_vuController=TextEditingController();
  TextEditingController bien_so_xeController=TextEditingController();
  TextEditingController hang_xeController=TextEditingController();
  TextEditingController ten_ngan_hangController=TextEditingController();
  TextEditingController ten_chu_tai_khoanController=TextEditingController();
  TextEditingController so_tai_khoanController=TextEditingController();


  @override
  void initState() {
    super.initState();
    nameController.text=global.user['name'];
    phoneController.text=global.user['phone'];
    phone_zaloController.text=global.user['phone_zalo'];
    ma_giam_satController.text=global.user['ma_giam_sat'].toString();
    cccdController.text=global.user['cccd'];
    loai_dich_vuController.text=getNameLDV(global.user['loai_dich_vu']);
    bien_so_xeController.text=global.user['bien_so_xe'];
    hang_xeController.text=global.user['hang_xe'];
    ten_ngan_hangController.text=global.user['ten_ngan_hang'];
    ten_chu_tai_khoanController.text=global.user['chu_tai_khoan'];
    so_tai_khoanController.text=global.user['so_tai_khoan'];
  }

  updateinfo() async {
    if (nameController.text.isEmpty) {
      global.showError('Vui lòng nhập họ và tên');
    }
    else {
      dynamic data=await sharedController.postUploadImage(avatar!.path.toString());
      if(data['error']==false){
        String imageUrl=data['data'];
        dynamic data2 = await authController.postUpdateinfo(nameController.text, imageUrl);
        if (data2['error'] == true) {
          global.showError(data2['message']);
        }
        else {
          global.showSuccess(data2['message']);
        }
      }
    }
  }

  getAvatar(){
    File image=File(avatar!.path.toString());
    return image;
  }

  getNameLDV(String str){
    List list=str.split(',');
    List nameList=[];
    for(int i=0;i<list.length;i++){
      for(int j=0;j<global.listLDV.length;j++){
        if(list[i].toString().trim()==global.listLDV[j]['id']){
          nameList.add(global.listLDV[j]['name']);
          break;
        }
      }
    }
    return nameList.join(', ');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Thông tin tài khoản',style: TextStyle(color: global.gold),),
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
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(global.borderImgPath),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text('THÔNG TIN CƠ BẢN', style: TextStyle(fontSize: 16, color: global.gold, fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Ảnh đại diện', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: global.black1,
                                ),
                                clipBehavior: Clip.antiAlias,
                                // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                // margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: avatar!=null?Image.file(getAvatar(), fit: BoxFit.fill,):Image.network(global.link+'/'+global.user["anh_chan_dung"], fit: BoxFit.fill,)
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
                              const Text('*', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),),
                            ],
                          ),
                        ),
                        TextField(
                          controller: nameController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Số điện thoại', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: phoneController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Số điện thoại Zalo', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: phone_zaloController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Mã giám sát', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Số căn cước công dân', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: cccdController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Loại dịch vụ', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: loai_dich_vuController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Biển số xe', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: bien_so_xeController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Hãng xe', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
                          controller: hang_xeController,
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Tên ngân hàng', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('Tên chủ tài khản', style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        TextField(
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
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: global.black1
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 2, 2, 2)
                          ),
                          cursorColor: Colors.grey,
                          style: TextStyle(color: global.grey),
                          obscureText: false,
                          readOnly: true,
                        ),
                        InkWell(
                          onTap: (){
                            updateinfo();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            decoration: BoxDecoration(
                                color: global.gold,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text('Lưu', style: TextStyle(fontSize: 16, color: global.black, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        )
                      ],
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
          ]
        ),
      ),
    );
  }
}
