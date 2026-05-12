import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({super.key, required this.path});
  final String path
  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {

  final PlayerController prepareContoller = PlayerController();

    void playerInit() async{
    await prepareContoller.preparePlayer(path: widget.path);
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
    return const Placeholder();
  }
}
