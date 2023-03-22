// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';

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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            FutureBuilder(
              future: NasaApi.getImage(url!),
              builder: (context, snapshot) {
                return Container(
                  width: width * 0.37,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data![1].toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )),
          ],
        ),
        Container(
            width: width * 0.37,
            height: height * 0.04,
            child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Text(
                    title!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )),
            ))
      ],
    );
  }
}
