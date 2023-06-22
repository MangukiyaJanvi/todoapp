import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/db_helper.dart';
import '../homescreen/controller/home_controller.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  int index = Get.arguments;
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    TextEditingController txttitle = TextEditingController(
        text: "${controller.readTotoList[index]['title']}");
    TextEditingController txtnotes = TextEditingController(
        text: "${controller.readTotoList[index]['notes']}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Update Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                "Enter Title",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: txttitle,
                cursorColor: Colors.black,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter Notes",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 100,
                child: TextFormField(
                  controller: txtnotes,
                  cursorColor: Colors.black,
                  maxLines: 50,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose Date",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 45,
                width: 207,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                child: TextButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: controller.currentdate.value,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                      builder: (context, child) => Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                                primary: Color(0XFF1E2140),
                                onPrimary: Colors.white,
                                onSurface: Colors.black),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Color(0XFF1E2140),
                              ),
                            ),
                          ),
                          child: child!),
                    );
                    controller.setdate(date!);
                  },
                  child: Obx(
                    () => Text(
                      "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 18),
                    ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     DateTime? date = await showDatePicker(
              //         context: context,
              //         initialDate: controller.currentdate.value,
              //         firstDate: DateTime(1950),
              //         lastDate: DateTime(2030),
              //         builder: (context, child) => Theme(
              //             data: Theme.of(context).copyWith(
              //               colorScheme: ColorScheme.light(
              //                   primary: Color(0XFF1E2140),
              //                   onPrimary: Colors.white,
              //                   onSurface: Colors.black),
              //               textButtonTheme: TextButtonThemeData(
              //                 style: TextButton.styleFrom(
              //                   primary: Color(0XFF1E2140),
              //                 ),
              //               ),
              //             ),
              //             child: child!));
              //     print("${date!.year}");
              //   },
              //   child: Container(
              //     height: 60,
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.black),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose Time",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedtime = await showTimePicker(
                    context: context,
                    initialTime: controller.currenttime.value,
                    builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!),
                  );
                  controller.currenttime.value = pickedtime!;
                },
                child: Container(
                  height: 60,
                  width: 207,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  padding: EdgeInsets.all(15),
                  child: Obx(
                    () => Text(
                      "${controller.currenttime.value.hour}:${controller.currenttime.value.minute}",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      DbHelper dbhelper = DbHelper();
                      int id = controller.readTotoList[index]['id'];
                      String date =
                          "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}";
                      controller.UpdateData(
                          priority: "High",
                          notes: txtnotes.text,
                          date: "$date",
                          time: "${controller.currenttime.value}",
                          title: txttitle.text,
                          id: id);
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    child: Text("High"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DbHelper dbhelper = DbHelper();
                      int id = controller.readTotoList[index]['id'];
                      String date =
                          "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}";
                      controller.UpdateData(
                          priority: "Low",
                          notes: txtnotes.text,
                          date: "$date",
                          time: "${controller.currenttime.value}",
                          title: txttitle.text,
                          id: id);
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    child: Text("Low"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DbHelper dbhelper = DbHelper();
                      int id = controller.readTotoList[index]['id'];
                      String date =
                          "${controller.currentdate.value.year}/${controller.currentdate.value.month}/${controller.currentdate.value.day}";
                      controller.UpdateData(
                          priority: "Urgent",
                          notes: txtnotes.text,
                          date: "$date",
                          time: "${controller.currenttime.value}",
                          title: txttitle.text,
                          id: id);
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    child: Text("Urgent"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
