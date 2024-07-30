import 'package:deliverydriver/class/global.dart' as global;
import 'package:deliverydriver/view/change_password_view.dart';
import 'package:deliverydriver/view/delete_view.dart';
import 'package:deliverydriver/view/profile_view.dart';
import 'package:deliverydriver/view/rate_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(global.backgroundImage1), fit: BoxFit.fill)),
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).viewPadding.top, 0, 0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(global.borderImgPath),
                      fit: BoxFit.fill)),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: const Border(),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          '${global.link}/${global.user['anh_chan_dung']}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        child: Text(
                          global.user['name'],
                          style: TextStyle(
                              color: global.gold,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      //color: global.black1,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const ProfileView());
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.solidIdCard,
                                    size: 20,
                                    color: global.gold,
                                  ),
                                  Text(
                                    '  Thông tin tài khoản',
                                    style: TextStyle(
                                        color: global.gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: global.gold,
                              )
                            ],
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: (){
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      //     margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             FaIcon(FontAwesomeIcons.locationDot, color: global.gold,),
                      //             Text('    Khu vực', style: TextStyle(color: global.gold,fontSize: 16, fontWeight: FontWeight.bold),),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.end,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             Text('Thành Phố ', style: TextStyle(color:global.gold,fontSize: 16),),
                      //             Icon(Icons.arrow_forward_ios, size: 18,color: global.gold,)
                      //           ],)
                      //
                      //       ],
                      //     ),
                      //
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ChangPassWordView());
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.key,
                                    size: 20,
                                    color: global.gold,
                                  ),
                                  Text(
                                    '  Đổi mật khẩu',
                                    style: TextStyle(
                                        color: global.gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: global.gold,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const RateView());
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.star,
                                    size: 20,
                                    color: global.gold,
                                  ),
                                  Text(
                                    '  Đánh giá của tôi',
                                    style: TextStyle(
                                        color: global.gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: global.gold,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.rightFromBracket,
                                    size: 20,
                                    color: global.gold,
                                  ),
                                  Text(
                                    '  Đăng xuất',
                                    style: TextStyle(
                                        color: global.gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: global.gold,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const DeleteView());
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.trashCan,
                                    size: 20,
                                    color: global.gold,
                                  ),
                                  Text(
                                    '  Yêu cầu xoá tài khoản',
                                    style: TextStyle(
                                        color: global.gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: global.gold,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(global.borderImgPath),
                      fit: BoxFit.fill)),
            ),
          ],
        ),
      ),
    );
  }
}
