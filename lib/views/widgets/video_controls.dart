import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoControls({super.key, required this.controller});
  
  @override
  State<StatefulWidget> createState() => VideoControlsState();
}

class VideoControlsState extends State<VideoControls> {
  VideoPlayerController? controller;

  final List<String> _exampleAudioLanguages = <String>[
    'Telugu',
    'Hindi',
    'Tamil',
  ];
  
  final List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
  ];

  final List<String> _qualityOptions = ['240p', '360p', '720p', '1080p'];

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    controller = widget.controller;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            controller!.value.isPlaying ? controller!.pause() : controller!.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed:() {},
            icon: const Icon(Icons.info_outline),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              IconButton(
                tooltip: controller!.value.isPlaying ? 'Pause' : 'Play',
                onPressed: () => controller!.value.isPlaying ? controller!.pause() : controller!.play(),
                icon: controller!.value.isPlaying ? const Icon(Icons.pause_outlined) : const Icon(Icons.play_arrow_outlined)
              ),
              IconButton(
                tooltip: controller!.value.volume==0 ? 'Unmute' : 'Mute',
                icon: controller!.value.volume==0 ? const Icon(Icons.volume_off_outlined) : const Icon(Icons.volume_up_outlined),
                onPressed: () => controller!.value.volume==0 ? controller!.setVolume(1) : controller!.setVolume(0),
              ),
              Text('${controller!.value.position.toString().split('.').first}/${controller!.value.duration.toString().split('.').first}'),
              PopupMenuButton<String>(
                initialValue: _exampleAudioLanguages.first,
                tooltip: 'Audio Language',
                onSelected: (String language) {
                  print(language);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    for (final language in _exampleAudioLanguages)
                      PopupMenuItem<String>(
                        value: language,
                        child: Text(language),
                      )
                  ];
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 6,
                  ),
                  child: Icon(Icons.multitrack_audio_outlined),
                ),
              ),
              PopupMenuButton<double>(
                initialValue: controller!.value.playbackSpeed,
                tooltip: 'Playback speed',
                onSelected: (double speed) {
                  controller!.setPlaybackSpeed(speed);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    for (final double speed in _examplePlaybackRates)
                      PopupMenuItem<double>(
                        value: speed,
                        child: Text('${speed}x'),
                      )
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Text('${controller!.value.playbackSpeed}x'),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.fullscreen)
              )
            ],
          ),
        ),
      ],
    );
  }
}