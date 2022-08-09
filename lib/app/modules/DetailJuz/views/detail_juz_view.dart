import 'package:app_quran/app/assets/theme/colors_constant.dart';
import 'package:app_quran/app/data/models/juz_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  const DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    JuzModels arguments = Get.arguments;
    print(arguments);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: arguments.ayahs!.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    Text(
                      arguments.ayahs![index].surah!.englishName.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorWhite,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      arguments.ayahs![index].text.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      " ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
