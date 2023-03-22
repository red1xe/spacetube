import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacetube/pages/podcast_page.dart';
import 'package:spacetube/widgets/gallery.dart';

import 'package:provider/provider.dart';

import '../provider/search_provider.dart';
import '../widgets/chips.dart';
import '../widgets/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const UpperBarWidget(),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/podcast');
                    },
                    icon: Icon(
                      Icons.music_note_rounded,
                      color: Colors.white,
                    )),
              ],
            )),
      ),
    );
  }
}

class galleryWidget extends StatelessWidget {
  const galleryWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: height * 0.65,
              decoration: BoxDecoration(
                color: const Color(0XFF222222),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            const GalleryView(),
          ],
        ),
      ],
    );
  }
}

class UpperBarWidget extends StatelessWidget {
  const UpperBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.network("https://img.icons8.com/color/12x/nasa.png"),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 220,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xff5A5A5A),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            'NASA Library',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cast,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWidget(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
      ],
    );
  }
}
