import 'package:deliverydriver/class/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DeleteView extends StatefulWidget {
  const DeleteView({super.key});

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  //var
  bool showCheck = false;
  //method
  delete() async {
    if (showCheck == false) {
      global.showError('Vui lòng xác nhận đồng ý với điều khoản');
    } else {
      global.showSuccess('Đã gửi yêu cầu xoá tài khoản');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text(
          'Yêu cầu xoá tài khoản',
          style: TextStyle(color: global.gold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: global.gold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(global.backgroundImage1), fit: BoxFit.fill)),
        //padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                      fit: BoxFit.fill)),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tài khoản bị xoá sẽ không thể khôi phục. Đồng thời, bạn sẽ không thể đăng nhập bằng tài khoản này được nữa. Bạn vui lòng xác nhận mình đã hiểu rằng xoá tài khoản sẽ làm mất những thông tin sau:',
                    style: TextStyle(fontSize: 16, color: global.gold),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin giao dịch:',
                          style: TextStyle(
                              color: global.gold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mọi thông tin lên quan đến giao dịch',
                          style: TextStyle(color: global.gold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin tài khoản:',
                          style: TextStyle(
                              color: global.gold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mọi thông tin lên quan đến tài khoản của bạn',
                          style: TextStyle(color: global.gold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Chúng tôi sẽ không chịu trách nhiệm cho bất kỳ mất mát nào  thông tin, dữ liệu hoặc tiền sau khi đã xoá tài khoản',
                      style: TextStyle(color: global.gold, fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: global.black1,
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                              'Tôi đồng ý với điều khoản và xác nhận muốn xoá tài khoản',
                              style:
                                  TextStyle(color: global.gold, fontSize: 16)),
                        ),
                        InkWell(
                          onTap: () {
                            showCheck = !showCheck;
                            setState(() {});
                          },
                          child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: global.gold, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: showCheck == false
                                    ? Container()
                                    : FaIcon(FontAwesomeIcons.check,
                                        size: 17, color: global.gold),
                              )),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      delete();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: global.black1,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Xoá tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: global.gold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: global.gold,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Huỷ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: global.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
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
