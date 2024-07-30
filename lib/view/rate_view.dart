import 'package:deliverydriver/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:intl/intl.dart';

class RateView extends StatefulWidget {
  const RateView({super.key});

  @override
  State<RateView> createState() => _RateViewState();
}

class _RateViewState extends State<RateView> {
  //var
  ReviewController reviewController=Get.find();
  List listReview=[];


  TextEditingController fromController=TextEditingController();
  TextEditingController toController=TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime fromDateTime = DateTime.now();
  DateTime toDateTime = DateTime.now();

  //method

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
    fromController.text=DateFormat('dd/MM/yyyy').format(fromDateTime);
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

  @override
  void initState() {
    super.initState();
    fromController.text=DateFormat('dd/MM/yyyy') .format(fromDateTime);
    toController.text=DateFormat('dd/MM/yyyy').format(toDateTime);
    getData();
  }


  getData() async{
    dynamic data=await reviewController.getReview(DateFormat('yyyy-MM-dd').format(fromDateTime),DateFormat('yyyy-MM-dd').format(toDateTime));
    if(data['error']==true){
      global.showError(data['message']);
    }
    else{
      listReview=data['data'];
    }
    setState(() {

    });
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: global.black,
        title: Text('Danh sách đánh giá',style: TextStyle(color: global.gold),),
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
                      height: 70,

                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex:1,

                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: InkWell(
                                  onTap: (){

                                  },
                                  child: TextField(
                                    controller: fromController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: global.black1,
                                        hintText: 'Từ ngày',
                                        hintStyle: TextStyle(fontSize: 16, color: global.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: global.gold
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: global.gold,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(20, 2, 2, 2),
                                        suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color: global.gold,)
                                    ),
                                    cursorColor: Colors.grey,
                                    style: TextStyle(color: global.grey),
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
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: InkWell(
                                  onTap: (){
                                  },
                                  child: TextField(
                                    controller: toController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: global.black1,
                                        hintText: 'Đến ngày',
                                        hintStyle: TextStyle(fontSize: 16, color: global.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: global.gold
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: global.gold
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(20, 2, 2, 2),
                                        suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color: global.gold,)
                                    ),
                                    readOnly: true,
                                    cursorColor: global.grey,
                                    style: TextStyle(color: global.grey),
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
                    ListView(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        shrinkWrap: true,
                        children: List.generate(listReview.length, (index){
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: global.black1,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.box,color: global.gold,),
                                    Text('  '+listReview[index]['order_code'].toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: global.gold),),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(listReview[index]['driver']['name'], style: TextStyle(color: global.gold,fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Đặt lúc: ', style: TextStyle(fontWeight: FontWeight.bold,color: global.gold,fontSize: 16,),),
                                      Text(DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(listReview[index]['order']['created_at'])), style: TextStyle(color: global.gold,fontSize: 16,),),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),

                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          for(int i=0;i<listReview[index]['star'];i++)
                                            Icon(Icons.star,color: global.yellow,size: 30,),
                                          for(int i=0;i<5-listReview[index]['star'];i++)
                                            Icon(Icons.star,color: Colors.white,size: 30,),
                                        ],
                                      ),
                                      Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(listReview[index]['created_at'])), style: TextStyle(fontSize: 16,color: global.gold,),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
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
