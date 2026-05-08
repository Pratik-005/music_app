import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/core/constants/server_constants.dart';
import 'package:music_app/core/failure/failure.dart';
import 'package:music_app/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstants.apiUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final resBody = jsonDecode(res.body);

      if (res.statusCode != 201) {
        return Left(Failure(resBody['detail']));
      }
      return Right(
        UserModel.fromMap(resBody['user']).copyWith(token: resBody['token']),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstants.apiUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final resBody = jsonDecode(res.body);
      if (res.statusCode != 200) {
        return Left(Failure(resBody['detail']));
      }
      return Right(UserModel.fromMap(resBody));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
