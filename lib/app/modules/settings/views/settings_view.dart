import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../controllers/settings_controller.dart';

class Public {
  static RxBool _status = false.obs;

  get status => _status;

  static GetStorage box = GetStorage();

  get boxData => box;
}

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Public._status == true ? Colors.black : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(left: 24),
            onPressed: () {
              Get.back();
              if (Public._status == true) {
                Public.box.write(
                  "darkMode",
                  {"darkMode": "darkON"},
                );
              } else {
                Public.box.remove("darkMode");
                Public.box.write(
                  "darkMode",
                  {"darkMode": "darkOFF"},
                );
              }

              print(Public.box.read("darkMode")["darkMode"]);
            },
            icon: Icon(Icons.arrow_back),
            color: Public._status == true ? Colors.white : Colors.black,
          ),
          title: Text(
            "Quran App Settings",
            style: TextStyle(
              fontFamily: "PoppinsBold",
              fontSize: 20,
              color: Public._status == true ? Colors.white : Color(0xFF672CBC),
            ),
          ),
          backgroundColor: Public._status == true ? Colors.black : Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 60,
        ),
        body: Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 800,
              child: Column(
                children: [
                  RowSettings(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Date Release",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Public._status == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        "10 June 2022",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Public._status == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark Mode",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Public._status == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Obx(
                        () => FlutterSwitch(
                          value: Public._status.value == true ? true : false,
                          onToggle: (val) {
                            Public._status.value = val;
                            print(Public._status.value);

                            GetStorage box = GetStorage();

                            if (Public._status == true) {
                              Public.box.write(
                                "darkMode",
                                {"darkMode": "darkON"},
                              );
                            } else {
                              Public.box.remove("darkMode");
                              Public.box.write(
                                "darkMode",
                                {"darkMode": "darkOFF"},
                              );
                            }

                            print(Public.box.read("darkMode")["darkMode"]);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Build By",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Public._status == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        "Dimas Febriyanto",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Public._status == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Version",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            color: Public._status == true ? Colors.white : Colors.black,
          ),
        ),
        Text(
          "1.1",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            color: Public._status == true ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
