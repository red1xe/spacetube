// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';
import 'package:spacetube/func/remove_string.dart';
import 'package:spacetube/pages/video_player_page.dart';

import '../func/random.dart';
import '../models/nasa_model.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NasaApi.getNasaData(
          query: recommendations[getRandomInt(recommendations.length)],
          media_type: "video"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final random = getRandomInt(snapshot.data!.length - 2);
          return Container(
            height: height * 0.35,
            width: width * 0.92,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff272727)),
            child: Column(children: [
              Container(
                  width: width * 0.92,
                  height: height * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data![random].url!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () =>
                        detailPageNavigator(context, snapshot, random),
                    icon: const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                  )),
              Container(
                width: width * 0.92,
                height: height * 0.08,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color(0xff272727),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                          "https://img.icons8.com/color/12x/nasa.png"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![0].title!,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            removelast(snapshot.data![0].date!),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ]),
          );
        } else {
          return Container(
            height: height * 0.35,
            width: width * 0.92,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void detailPageNavigator(BuildContext context,
      AsyncSnapshot<List<NasaModel>> snapshot, int random) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoPage(
                  title: snapshot.data![random].title,
                  date: snapshot.data![random].date,
                  url: snapshot.data![random].url,
                  description: snapshot.data![random].description,
                  hdurl: snapshot.data![random].hdurl,
                  keywords: snapshot.data![random].keywords,
                  mediaType: snapshot.data![random].mediaType,
                  center: snapshot.data![random].center,
                )));
  }

  static const List<String> recommendations = [
    "galaxy",
    "nebula",
    "space",
    "stars",
    "universe",
    "jupiter",
    "saturn",
    "neptune",
    "uranus",
    "pluto",
    "mercury",
    "venus",
    "earth",
    "sun",
    "moon",
    "asteroid",
    "comet",
    "meteor",
    "meteorite",
    "cosmos",
    "apollo",
  ];
}
