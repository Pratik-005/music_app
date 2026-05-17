import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/providers/current_user_notifier.dart';
import 'package:music_app/core/utils/color_convertor.dart';
import 'package:music_app/features/home/model/song_model.dart';
import 'package:music_app/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final token = ref.watch(currentUserProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectAudio,
    required File selectedThumbnail,
    required String artistName,
    required String songName,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectAudio: selectAudio,
      selectedThumbnail: selectedThumbnail,
      artistName: artistName,
      songName: songName,
      hexcode: rgbToHex(selectedColor),
      token: ref.read(currentUserProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }
}
