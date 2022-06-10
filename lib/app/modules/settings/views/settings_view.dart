import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  RxBool _status = false.obs;

  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: box.read("darkMode")["darkMode"] == "darkON"
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 24),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          "Quran App Settings",
          style: TextStyle(
              fontFamily: "PoppinsBold",
              fontSize: 20,
              color: Color(0xFF672CBC)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
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
                    ),
                  ),
                  Text(
                    "10 June 2022",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
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
                    ),
                  ),
                  Obx(
                    () => FlutterSwitch(
                      value: _status.value,
                      onToggle: (val) {
                        _status.value = val;
                        print(_status);

                        GetStorage box = GetStorage();

                        if (_status == true) {
                          box.write(
                            "darkMode",
                            {"darkMode": "darkON"},
                          );
                        } else {
                          box.remove("darkMode");
                          box.write(
                            "darkMode",
                            {"darkMode": "darkOFF"},
                          );
                        }

                        print(box.read("darkMode")["darkMode"]);
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
                    ),
                  ),
                  Text(
                    "Dimas Febriyanto",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                    ),
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
          ),
        ),
        Text(
          "1.1",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
