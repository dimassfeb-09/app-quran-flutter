import 'dart:convert';

import 'package:app_quran/app/assets/theme/colors_constant.dart';
import 'package:app_quran/app/data/models/surah_model.dart';
import 'package:app_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/detailsurah_model.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  const DetailSurahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SurahModels arguments = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.nameSimple),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () async {
                  Uri url = Uri.parse(
                      "http://api.quran.com/api/v3/chapters/${arguments.id}/info?language=id");
                  var response = await http.get(url);

                  Map<String, dynamic> fetchData = (jsonDecode(response.body)
                      as Map<String, dynamic>)['chapter_info'];

                  Get.defaultDialog(
                    title: arguments.nameSimple,
                    middleText: fetchData['short_text'],
                  );
                },
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.blue,
                child: Ink(
                  padding: EdgeInsets.all(20),
                  height: 130,
                  decoration: BoxDecoration(
                    color: colorPrimary.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          arguments.nameSimple,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colorWhite,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          arguments.translatedName.name,
                          style: TextStyle(
                            color: colorWhite,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1,
                          color: colorWhite,
                        ),
                        SizedBox(height: 10),
                        Text(
                          arguments.revelationPlace.toUpperCase() +
                              " " +
                              "(${arguments.versesCount.toString()})",
                          style: TextStyle(
                            color: colorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<DetailSurah>>(
              future: controller.getDetailSurah(id: arguments.id),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var detailSurah = snapshot.data![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text("${index + 1}"),
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
                                  detailSurah.textMadani,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  detailSurah.translations[0].text,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
