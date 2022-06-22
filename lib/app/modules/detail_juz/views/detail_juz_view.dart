import 'package:app_quran/app/modules/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_quran/app/data/models/juz_model.dart' as juzModel;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/detail_juz_controller.dart';
import '../../../data/models/detailsurah_model.dart' as detailSurah;
import 'package:http/http.dart' as http;
import '../../home/controllers/home_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  juzModel.Juz juz = Get.arguments;

  HomeController homeController = Get.put(HomeController());

  Public public = Public();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: public.status == true ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 24),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: public.status == true ? Colors.white : Colors.black,
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
        backgroundColor: public.status == true ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: ListView(
        children: [
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
                      Text(
                        "Juz ${juz.juz}",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontFamily: "PoppinsReg"),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${juz.start} s/d ${juz.end}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "PoppinsReg"),
                      ),
                      Divider(),
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
            padding: const EdgeInsets.all(24),
            child: FutureBuilder<List<juzModel.Juz>>(
              future: homeController.getDetailJuz(juz.juz.toString()),
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      juzModel.Juz getDetailJuz = snapshot.data![index];
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
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
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
                              "${getDetailJuz.verses![index].text!.arab}",
                              style: TextStyle(
                                  fontSize: 32,
                                  height: 2,
                                  color: public.status == true
                                      ? Colors.white
                                      : Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${getDetailJuz.verses![index].translation!.id}",
                            style: TextStyle(
                              fontSize: 16,
                              color: public.status == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
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
