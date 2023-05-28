// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spacetube/apis/nasa_lib_api.dart';
import 'package:spacetube/func/httptohttps.dart';
import 'package:spacetube/func/remove_string.dart';

import 'package:spacetube/models/nasa_model.dart';

import '../widgets/podcast.dart';

class PodcastPage extends StatefulWidget {
  final String? url;
  final String? title;
  final String? description;
  final String? date;
  final String? mediaType;
  final String? center;
  final String? nasaId;
  final List<dynamic>? keywords;
  final List<NasaModel>? searchlist;

  const PodcastPage({
    Key? key,
    this.url,
    this.title,
    this.description,
    this.date,
    this.mediaType,
    this.center,
    this.nasaId,
    this.keywords,
    this.searchlist,
  }) : super(key: key);

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  late AudioPlayer _audioPlayer;

  late var _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse(widget.url!),
        tag: MediaItem(
          id: 'id',
          album: widget.center!,
          title: widget.title!,
          artist: removelast(widget.date!),
          artUri: Uri.parse(
              'https://cdn-icons-png.flaticon.com/512/3921/3921633.png'),
        ),
      ),
    ],
  );

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _init();

    super.initState();
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(_playlist);
    await _audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff2c5fd8),
              Color(0xff191A22),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final sequenceState = snapshot.data;
                if (sequenceState?.sequence.isEmpty ?? true) {
                  return const SizedBox.shrink();
                }
                final mediaItem =
                    sequenceState!.currentSource!.tag as MediaItem;
                return MediaMetaData(
                  imageurl: mediaItem.artUri.toString(),
                  title: mediaItem.title,
                  center: mediaItem.album,
                  date: mediaItem.artist,
                );
              },
            ),
            const SizedBox(height: 20),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  thumbRadius: 8.0,
                  baseBarColor: Colors.grey.shade800,
                  bufferedBarColor: Colors.grey.shade600,
                  timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                );
              },
            ),
            const SizedBox(height: 20),
            Controls(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  const PositionData(this.position, this.bufferedPosition, this.duration);
}
