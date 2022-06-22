import 'package:app_quran/app/assets/theme/colors_constant.dart';
import 'package:app_quran/app/modules/settings/views/settings_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:app_quran/app/data/models/surah_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../data/models/detailsurah_model.dart' as detailSurah;

import '../controllers/detail_surah_controller.dart';

import '../../home/controllers/home_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  HomeController homeController = Get.put(HomeController());

  Surah surah = Get.arguments;

  Public public = Public();

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
          color: box.read("darkMode")["darkMode"] == "darkON"
              ? Colors.white
              : Colors.black,
        ),
        title: Text(
          "Quran App",
          style: TextStyle(
              fontFamily: "PoppinsBold",
              fontSize: 20,
              color: Color(0xFF672CBC)),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 24),
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: box.read("darkMode")["darkMode"] == "darkON"
            ? Colors.black
            : Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: ListView(
        children: [
          SizedBox(height: 24),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  image: AssetImage("assets/images/FrameDetailSurah.png"),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 54, left: 58, right: 58),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Get.defaultDialog(
                          radius: 10,
                          titleStyle: TextStyle(
                            color: public.status == true
                                ? Colors.white
                                : Colors.black,
                          ),
                          title: "${surah.name!.transliteration!.id}",
                          onCancel: () {},
                          cancelTextColor: public.status == true
                              ? Colors.white
                              : Colors.black,
                          buttonColor: PurpleApp,
                          backgroundColor: public.status == true
                              ? Colors.black
                              : Colors.white,
                          content: Text(
                            "${surah.tafsir!.id}",
                            style: TextStyle(
                              color: public.status == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        child: Text(
                          "${surah.name!.transliteration!.id}",
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontFamily: "PoppinsReg"),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${surah.name!.translation!.id}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "PoppinsReg"),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                          "${surah.revelation!.id} - ${surah.numberOfVerses} Ayat",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "PoppinsReg")),
                      SizedBox(height: 32),
                      Image(
                          image: AssetImage("assets/images/Bismilla.png"),
                          height: 48,
                          width: 214),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<detailSurah.DetailSurah>(
              future: homeController.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: Colors.grey, size: 50),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.numberOfVerses,
                    itemBuilder: (context, index) {
                      detailSurah.DetailSurah getDetailSurah = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 47,
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F0FF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xFF863ED5),
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 10),
                                      Icon(Icons.play_arrow_outlined),
                                      SizedBox(width: 10),
                                      Icon(Icons.bookmark_border),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "${getDetailSurah.verses![index].text!.arab}",
                              style: TextStyle(
                                  fontSize: 32,
                                  height: 2,
                                  color: box.read("darkMode")["darkMode"] ==
                                          "darkON"
                                      ? Colors.white
                                      : Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${getDetailSurah.verses![index].translation!.id}",
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    box.read("darkMode")["darkMode"] == "darkON"
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          SizedBox(height: 16),
                          Divider(
                            thickness: 1,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarCustomDetailSurah extends StatelessWidget {
  const AppBarCustomDetailSurah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              iconSize: 24,
            ),
            SizedBox(width: 24),
            Text(
              "Quran App",
              style: TextStyle(
                  fontFamily: "PoppinsBold",
                  fontSize: 20,
                  color: Color(0xFF672CBC)),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}


/*

  Future<List<Detailsurah>> getDetailSurah(String id) async {
    var response =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$id"));

    List data = (jsonDecode(response.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Detailsurah.fromJson(e)).toList();
    }
  }

 */