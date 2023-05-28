// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spacetube/animation/rotation.dart';
import 'package:spacetube/func/remove_string.dart';

class MediaMetaData extends StatelessWidget {
  final String? imageurl;
  final String? title;
  final String? description;
  final String? date;
  final String? mediaType;
  final String? center;

  const MediaMetaData({
    Key? key,
    this.imageurl,
    this.title,
    this.description,
    this.date,
    this.mediaType,
    this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 0.0),
              )
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Rotation(
                imageurl: imageurl,
              )),
        ),
        const SizedBox(height: 20),
        Text(
          title!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.place_outlined,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              center!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              date!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 50,
          icon: const Icon(Icons.skip_previous_rounded),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: audioPlayer.seekToPrevious,
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                iconSize: 50,
                icon: const Icon(Icons.play_arrow_rounded),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: processingState == ProcessingState.completed
                    ? () => audioPlayer.seek(Duration.zero,
                        index: audioPlayer.effectiveIndices!.first)
                    : audioPlayer.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                iconSize: 50,
                icon: const Icon(Icons.pause_rounded),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: audioPlayer.pause,
              );
            } else {
              return IconButton(
                iconSize: 50,
                icon: const Icon(Icons.replay_rounded),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => audioPlayer.seek(Duration.zero,
                    index: audioPlayer.effectiveIndices!.first),
              );
            }
          },
        ),
        IconButton(
          iconSize: 50,
          icon: const Icon(Icons.skip_next_rounded),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: audioPlayer.seekToNext,
        ),
      ],
    );
  }
}
