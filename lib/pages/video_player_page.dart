import 'package:flutter/material.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';
import 'package:spacetube/func/groupLinks.dart';
import 'package:spacetube/widgets/player.dart';

import '../func/httptohttps.dart';
import '../func/keywordChips.dart';
import '../func/remove_string.dart';

class VideoPage extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  final String? description;
  final String? hdurl;
  final List? keywords;
  final String? mediaType;
  final String? center;
  const VideoPage({
    Key? key,
    this.title,
    this.date,
    this.url,
    this.description,
    this.hdurl,
    this.keywords,
    this.mediaType,
    this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NasaApi.getVideo(hdurl!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.35,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: const Color(0xff272727),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: PlayerWidget(
                    url: httpsConverter(groupmp4links(snapshot.data!)[0]),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(title!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        width: width * 0.8,
                        child: Row(
                          children: [
                            Icon(Icons.date_range_rounded,
                                size: 20, color: Colors.white),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(removelast(date!),
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.fade,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Spacer(),
                            Icon(Icons.location_on_rounded,
                                size: 20, color: Colors.white),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(center!,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.fade,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width * 0.9,
                        child: Text(description!,
                            softWrap: true,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                overflow: TextOverflow.fade,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width * 0.9,
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: keywordChips(context, keywords!)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
