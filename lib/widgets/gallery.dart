import 'package:flutter/material.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';
import 'package:spacetube/func/random.dart';
import 'package:spacetube/models/nasa_model.dart';
import 'package:spacetube/pages/image_details_page.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NasaApi.getNasaData(
          query: recommendations[getRandomInt(recommendations.length)]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final random = getRandomInt(snapshot.data!.length - 2);
          return Container(
            height: height * 0.6,
            width: width * 0.915,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Theme.of(context).primaryColor,
                  onTap: () => detailPageNavigator(context, snapshot, random),
                  child: Container(
                    width: width * 0.915,
                    height: width * 0.259,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data![random].url.toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.43,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Theme.of(context).primaryColor,
                            onTap: () => detailPageNavigator(
                                context, snapshot, random + 1),
                            child: Container(
                                width: width * 0.432,
                                height: height * 0.2,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            0, 4), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data![random + 1].url
                                            .toString()),
                                        fit: BoxFit.cover))),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Theme.of(context).primaryColor,
                            onTap: () => detailPageNavigator(
                                context, snapshot, random + 2),
                            child: Container(
                              width: width * 0.432,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: const Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data![random + 2].url
                                          .toString()),
                                      fit: BoxFit.cover)),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Theme.of(context).primaryColor,
                      onTap: () =>
                          detailPageNavigator(context, snapshot, random + 3),
                      child: Container(
                        height: height * 0.43,
                        width: width * 0.432,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data![random + 3].url.toString()),
                              fit: BoxFit.cover),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
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
            builder: (context) => ImagePage(
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
