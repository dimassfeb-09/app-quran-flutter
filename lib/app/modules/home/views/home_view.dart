import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_quran/app/routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

import '../../../data/models/juz_model.dart' as juzModel;
import '../controllers/home_controller.dart';
import '../../../data/models/surah_model.dart' as surahModel;
import '../../../assets/theme/colors_constant.dart';

RxString lastReadSurah = ''.obs;
RxString lastReadSurahKe = ''.obs;

@override
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 300,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            AppBarCustom(),
            SalamNameCustom(),
            LastReadCustom(),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.purple,
                indicatorColor: Colors.purple,
                unselectedLabelColor: Colors.purple[200],
                tabs: [
                  Tab(text: "Surah"),
                  Tab(text: "Juz"),
                  Tab(text: "Bookmark"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView(
                      children: [
                        FutureBuilder<List<surahModel.Surah>>(
                          future: controller.getSurah(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  surahModel.Surah surah =
                                      snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      GetStorage box = GetStorage();

                                      box.write("lastRead", {
                                        "surah":
                                            "${surah.name!.transliteration!.id}",
                                        "surahKe": "${surah.number}",
                                      });

                                      if (box.read("lastRead") != null) {
                                        lastReadSurah.value =
                                            box.read("lastRead")["surah"];
                                        lastReadSurahKe.value =
                                            box.read("lastRead")["surahKe"];
                                      } else {
                                        lastReadSurah.value = 'Belum Baca';
                                      }

                                      Get.toNamed(Routes.DETAIL_SURAH,
                                          arguments: surah);
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/CircleAvatar.png"),
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "${surah.number}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    title: Text(
                                        "${surah.name!.transliteration!.id} (${surah.name!.translation!.id})"),
                                    subtitle: Text(
                                        "${surah.numberOfVerses} Ayat - ${surah.revelation!.id}"),
                                  );
                                },
                              );
                            } // else
                          },
                        ),
                      ],
                    ),
                    ListView(
                      children: [
                        FutureBuilder<List<juzModel.Juz>>(
                          future: controller.getJuz(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  juzModel.Juz juz = snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAIL_JUZ,
                                          arguments: juz);
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/CircleAvatar.png"),
                                      backgroundColor: Colors.transparent,
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                    title: Text("Juz ${juz.juz}"),
                                    subtitle:
                                        Text("${juz.start} sampai ${juz.end}"),
                                  );
                                },
                              );
                            } // else
                          },
                        ),
                      ],
                    ),
                    Tab(
                      text: "AASAA",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LastReadCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();

    GetStorage box = GetStorage();

    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_SURAH),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Image(
                image: AssetImage("assets/images/FrameTerakhirLihat.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19, left: 44),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book),
                        Text("Terakhir Dibaca",
                            style: TextStyle(
                                fontFamily: "PoppinsReg", fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${lastReadSurah.value.toString() != '' ? '${lastReadSurah.value.toString()}' : 'Belum Baca'}",
                      style: TextStyle(fontFamily: "PoppinsReg", fontSize: 18),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Surah Ke - ${lastReadSurahKe.value}",
                      style: TextStyle(fontFamily: "PoppinsReg", fontSize: 14),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class SalamNameCustom extends StatelessWidget {
  const SalamNameCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 24, left: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Assalamualaikum",
              style: TextStyle(
                  fontFamily: "PoppinsReg", fontSize: 18, color: Colors.black)),
          Text("Dimas Febriyanto",
              style: TextStyle(
                  fontFamily: "PoppinsReg", fontSize: 24, color: Colors.black)),
        ],
      ),
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image(
                  image: AssetImage("assets/images/MenuIcon.png"),
                ),
              ),
              SizedBox(width: 24),
              Text(
                "Quran App",
                style: TextStyle(
                    fontFamily: "PoppinsBold", fontSize: 20, color: PurpleApp),
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
    );
  }
}

// class AppBarCustom extends StatelessWidget {
//   const AppBarCustom({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             SizedBox(width: 24),
//             IconButton(
//               onPressed: () {},
//               icon: Image(
//                 image: AssetImage("assets/images/MenuIcon.png"),
//               ),
//               iconSize: 24,
//             ),
//             SizedBox(width: 24),
//             Text(
//               "Quran App",
//               style: TextStyle(
//                   fontFamily: "PoppinsBold",
//                   fontSize: 20,
//                   color: Color(0xFF672CBC)),
//             ),
//           ],
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.search),
//         ),
//       ],
//     );
//   }
// }

/*

  FutureBuilder<List<Surah>>(
              future: getSurah(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Surah surah = snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_SURAH);
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/CircleAvatar.png"),
                          backgroundColor: Colors.white,
                          child: Text(
                            "${surah.number}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        title: Text(
                            "${surah.name!.transliteration!.id} (${surah.name!.translation!.id})"),
                        subtitle: Text(
                            "${surah.numberOfVerses} Ayat - ${surah.revelation!.id}"),
                      );
                    },
                  );
                } // else
              },
            ),

 */

/*

  TabBar(
                tabs: [
                  Tab(
                    text: "SURAH",
                  ),
                  Tab(
                    text: "JUZ",
                  ),
                  Tab(
                    text: "BOOKMARK",
                  ),
                ],
              ),
              TabBarView(
                children: [
                  Text("HALO"),
                  Text("HALO"),
                  Text("HALO"),
                ],
              ),

 */


// TabBarView(
//                     children: [
//                       FutureBuilder<List<Surah>>(
//                         future: getSurah(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           } else {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: snapshot.data!.length,
//                               itemBuilder: (context, index) {
//                                 Surah surah = snapshot.data![index];
//                                 return ListTile(
//                                   onTap: () {
//                                     Get.toNamed(Routes.DETAIL_SURAH);
//                                   },
//                                   leading: CircleAvatar(
//                                     backgroundImage: AssetImage(
//                                         "assets/images/CircleAvatar.png"),
//                                     backgroundColor: Colors.white,
//                                     child: Text(
//                                       "${surah.number}",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   title: Text(
//                                       "${surah.name!.transliteration!.id} (${surah.name!.translation!.id})"),
//                                   subtitle: Text(
//                                       "${surah.numberOfVerses} Ayat - ${surah.revelation!.id}"),
//                                 );
//                               },
//                             );
//                           } // else
//                         },
//                       ),
//                       ListView.builder(
//                         itemCount: 30,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.red,
//                               child: Text("${index + 1}"),
//                             ),
//                           );
//                         },
//                       ),
//                       ListView.builder(
//                         itemCount: 30,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             leading: CircleAvatar(
//                               child: Text("${index + 1}"),
//                               backgroundColor: Colors.green,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),