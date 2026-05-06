import 'package:fpdart/fpdart.dart';
import 'package:music_app/features/auth/model/user_model.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    final result = switch (res) {
      Left(value: final l) => state = AsyncValue.error(l, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    print(result);
  }
}
