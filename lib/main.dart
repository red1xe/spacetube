import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spacetube/pages/main_page.dart';
import 'package:spacetube/pages/image_details_page.dart';
import 'package:provider/provider.dart';
import 'package:spacetube/pages/podcast_page.dart';
import 'package:spacetube/pages/video_player_page.dart';
import 'package:spacetube/provider/search_provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/home': (context) => const HomePage(),
          '/image': (context) => ImagePage(),
          '/video': (context) => const VideoPage(),
          '/podcast': (context) => const PodcastPage(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            background: const Color(0xff191A22),
            primary: const Color(0xff6E44FF),
            secondary: const Color(0xffefe9f5),
            error: const Color(0xff601410),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
