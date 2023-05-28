// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';

import '../func/random.dart';
import '../models/nasa_model.dart';
import '../pages/podcast_page.dart';

class Shorts extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  const Shorts({
    Key? key,
    this.title,
    this.date,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NasaApi.getNasaData(
          query: recommendations[getRandomInt(recommendations.length)],
          media_type: 'audio'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PodcastPass(snapshot.data!, index),
                                ));
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: width * 0.37,
                                height: height * 0.25,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.5),
                                      Colors.black.withOpacity(0.5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/3197/3197685.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                            width: width * 0.37,
                            height: height * 0.04,
                            child: ClipRRect(
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Text(
                                    snapshot.data![index].title.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  )),
                            ))
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Container(
            width: width * 0.37,
            height: height * 0.25,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
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

Widget PodcastPass(
  List<NasaModel> data,
  int index,
) {
  return FutureBuilder(
    future: NasaApi.getAudio(data[index].hdurl!),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return PodcastPage(
          title: data[index].title!,
          description: data[index].description!,
          date: data[index].date!,
          keywords: data[index].keywords!,
          url: snapshot.data![0],
          mediaType: data[index].mediaType!,
          center: data[index].center!,
        );
      } else if (snapshot.hasError) {
        return Text(snapshot.error as String);
      } else {
        return Container(
          color: const Color(0xff191A22),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xff6E44FF),
            ),
          ),
        );
      }
    },
  );
}
