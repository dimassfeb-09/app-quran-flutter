import 'package:app_quran/app/assets/theme/colors_constant.dart';
import 'package:app_quran/app/data/models/juz_model.dart';
import 'package:app_quran/app/data/models/surah_model.dart';
import 'package:app_quran/app/modules/DetailJuz/controllers/detail_juz_controller.dart';
import 'package:app_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  HomeController homeController = HomeController();

  DetailJuzController detailJuzController = DetailJuzController();

  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [
      GetSurahWidget(controller: controller),
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: FutureBuilder<List<JuzModels>>(
          future: controller.getJuz(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("LOADING"),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  JuzModels juz = snapshot.data![index];
                  return ListTile(
                    onTap: () async {
                      Get.toNamed(Routes.DETAIL_JUZ, arguments: juz);
                    },
                    leading: CircleAvatar(
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: colorWhite),
                      ),
                      backgroundColor: colorPrimary,
                    ),
                    title: Text("Juz ke ${index + 1}"),
                  );
                },
              );
            }
          },
        ),
      ),
      Container(
        height: 100,
        width: 100,
        child: Text("Menu Bookmark"),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Baca Al Quran",
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.notifications, color: colorWhite),
                            SizedBox(width: 10),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://i.ibb.co/YpKbD3P/image.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 60,
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.chrome_reader_mode_rounded),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Last Read"),
                                    SizedBox(height: 5),
                                    Text(controller.lastReadTitle.value == ""
                                        ? 'Belum baca'
                                        : controller.lastReadTitle.value),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                controller.lastReadArab.value == ""
                                    ? ''
                                    : controller.lastReadArab.value
                                        .split("سُورَةُ")
                                        .last,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SelectMenu(
                      controller: controller,
                      title: "Surah",
                      index: 0,
                    ),
                    SelectMenu(
                      controller: controller,
                      title: "Juz",
                      index: 1,
                    ),
                    SelectMenu(
                      controller: controller,
                      title: "Bookmark",
                      index: 2,
                    ),
                  ],
                ),
              ),
              Obx(
                () => Container(
                  child: menu.elementAt(controller.selectedMenu.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectMenu extends StatelessWidget {
  const SelectMenu({
    Key? key,
    required this.controller,
    required this.index,
    required this.title,
  }) : super(key: key);

  final HomeController controller;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedMenu.value = index;
        },
        child: Container(
          margin: EdgeInsets.all(10),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedMenu.value == index
                ? colorPrimarySoft
                : colorPrimarySoft.withOpacity(0.3),
            borderRadius: BorderRadius.circular(500),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: colorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class GetSurahWidget extends StatelessWidget {
  const GetSurahWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SurahModels>>(
      future: controller.getSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var surah = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    controller.lastReadTitle.value = surah.nameSimple;
                    controller.lastReadArab.value = surah.nameArabic;

                    Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                  },
                  leading: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: colorWhite),
                    ),
                    backgroundColor: colorPrimary,
                  ),
                  title: Text(surah.nameSimple),
                  subtitle: Text(
                    "${surah.translatedName.name} (${surah.versesCount})",
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
