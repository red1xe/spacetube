// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerWidget extends StatefulWidget {
  final String? url;
  const PlayerWidget({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.network(
      widget.url!,
    );
    await videoPlayerController.initialize().then((value) => setState(() {}));

    chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(
        playedColor: Theme.of(context).primaryColor,
        handleColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white,
      ),
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint(widget.url!),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: () => debugPrint('Option 2 pressed!'),
            iconData: Icons.share,
            title: 'Option 2',
          ),
        ];
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewieController != null
        ? Chewie(controller: chewieController!)
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
