import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/providers/current_song_notifier.dart';
import 'package:music_app/core/theme/app_pallate.dart';
import 'package:music_app/core/utils/color_convertor.dart';

class SongSlab extends ConsumerWidget {
  const SongSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final songNotifier = ref.watch(currentSongProvider.notifier);

    if (currentSong == null) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: hexToColor(currentSong!.hex_code),
            ),
            height: 66,
            width: MediaQuery.of(context).size.width - 16,
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(currentSong.thumbnail_url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.song_name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          currentSong.artist,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppPallate.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: AppPallate.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: songNotifier.playAndPause,
                      icon: Icon(
                        songNotifier.isPlaying
                            ? CupertinoIcons.pause_fill
                            : CupertinoIcons.play_fill,
                        color: AppPallate.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              final position = snapshot.data;
              final duration = songNotifier.audioPlayer!.duration;
              double sliderVal = 0.0;
              if (position != null && duration != null) {
                sliderVal = position.inMicroseconds / duration.inMicroseconds;
              }
              return Positioned(
                left: 8,
                bottom: 0,
                child: Container(
                  height: 2,
                  width: sliderVal * (MediaQuery.of(context).size.width - 32),
                  decoration: BoxDecoration(
                    color: AppPallate.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              );
            },
            stream: songNotifier.audioPlayer!.positionStream,
          ),
          Positioned(
            left: 8,
            bottom: 0,
            width: MediaQuery.of(context).size.width - 32,
            child: Container(
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: AppPallate.inactiveSeekColor,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ],
      );
    }
    return const Placeholder();
  }
}
