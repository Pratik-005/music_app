import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallate.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({super.key, required this.path});
  final String path;
  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController prepareContoller = PlayerController();

  void playerInit() async {
    await prepareContoller.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    if (!prepareContoller.playerState.isPlaying) {
      await prepareContoller.startPlayer(forceRefresh: false);
    } else if (!prepareContoller.playerState.isPaused) {
      await prepareContoller.pausePlayer();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    playerInit();
  }

  @override
  void dispose() {
    super.dispose();
    prepareContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: prepareContoller.playerState.isPlaying
              ? Icon(CupertinoIcons.pause_solid)
              : Icon(CupertinoIcons.play_arrow_solid),
        ),
        Expanded(
          child: AudioFileWaveforms(
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: AppPallate.borderColor,
              liveWaveColor: AppPallate.gradient2,
              spacing: 6,
              showSeekLine: false,
            ),
            waveformType: WaveformType.fitWidth,
            size: Size(double.infinity, 100),
            playerController: prepareContoller,
          ),
        ),
      ],
    );
  }
}
