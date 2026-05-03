import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/core/failure/failure.dart';
import 'package:music_app/features/auth/model/user_model.dart';

class AuthRemoteRepository {
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final resBody = jsonDecode(res.body);

      if (res.statusCode != 201) {
        return Left(Failure(resBody['detail']));
      }
      return Right(UserModel.fromMap(resBody));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(res.body);
  }
}
