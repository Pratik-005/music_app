import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/core/constants/server_constants.dart';
import 'package:music_app/core/failure/failure.dart';
import 'package:music_app/features/home/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<Failure, String>> uploadSong({
    required File selectAudio,
    required File selectedThumbnail,
    required String artistName,
    required String songName,
    required String hexcode,
    required String token,
  }) async {
    try {
      final req = await http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstants.apiUrl}/song/upload'),
      );

      req
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectAudio.path),
          await http.MultipartFile.fromPath(
            'thumbnail',
            selectedThumbnail.path,
          ),
        ])
        ..fields.addAll({
          'artist_name': artistName,
          'song_name': songName,
          'hex_code': hexcode,
        })
        ..headers.addAll({'x_auth_token': token});

      final res = await req.send();

      if (res.statusCode != 201) {
        return left(Failure(await res.stream.bytesToString()));
      }

      return right(await res.stream.bytesToString());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<SongModel>>> getSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.apiUrl}/song/list'),
        headers: {'x_auth_token': token, 'Content-Type': 'application/json'},
      );

      var body = jsonDecode(res.body);

      if (res.statusCode != 201) {
        body = body as Map<String, dynamic>;
        return left(Failure(body['detail']));
      }

      body = body as List;

      final songs = body.map((e) => SongModel.fromJson(e)).toList();
      return right(songs);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
