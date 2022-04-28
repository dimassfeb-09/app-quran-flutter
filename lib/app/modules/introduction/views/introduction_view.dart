import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:app_quran/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 86),
                Text(
                  "Quran App",
                  style: TextStyle(
                    fontFamily: "PoppinsBold",
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Learn Quran and \nRecite once everyday",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PoppinsReg",
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 49),
                Image(
                  image: AssetImage("assets/images/AlQuran.png"),
                  height: 450,
                  width: 314,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 660, left: 65, right: 65),
              child: InkWell(
                onTap: () => Get.offNamed(Routes.HOME),
                child: Image(
                  image: AssetImage("assets/images/Button.png"),
                  height: 60,
                  width: 185,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
