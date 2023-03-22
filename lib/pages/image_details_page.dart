// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:spacetube/apis/nasa_lib_api.dart';
import 'package:spacetube/func/remove_string.dart';

import '../func/keywordChips.dart';

class ImagePage extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  final String? description;
  final String? hdurl;
  final List? keywords;
  final String? mediaType;
  final String? center;
  ImagePage({
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
    return Scaffold(
        body: FutureBuilder(
            future: NasaApi.getImage(hdurl!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data![0].toString()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: height * 0.11,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Center(
                                  child: Container(
                                alignment: Alignment.center,
                                width: width * 0.7,
                                child: Text(title!,
                                    softWrap: true,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: width,
                              height: height * 0.14,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  detailsSheet(context, height, width);
                                },
                                icon: Icon(Icons.keyboard_arrow_up_rounded),
                                label: Text('Details'))
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  void detailsSheet(BuildContext context, double height, double width) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: height * 0.6,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width * 0.92,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        label: Text('Details')),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width * 0.8,
                    child: Column(
                      children: [
                        Text(title!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: width * 0.8,
                          child: Row(
                            children: [
                              Icon(Icons.date_range_rounded, size: 20),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(removelast(date!),
                                  softWrap: true,
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Icon(Icons.location_on_rounded, size: 20),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(center!,
                                  softWrap: true,
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: width * 0.8,
                          child: Text(description!,
                              softWrap: true,
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: width * 0.8,
                          child: Row(
                            children: [
                              Icon(Icons.keyboard_rounded, size: 20),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(child: keywordChips(context, keywords!)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
