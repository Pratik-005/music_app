import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:music_app/core/theme/app_pallate.dart';
import 'package:music_app/core/utils/show_snackbar.dart';
import 'package:music_app/core/widgets/loader.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/view/widgets/custom_field.dart';
import 'package:music_app/features/auth/view/widgets/gradient_button.dart';
import 'package:music_app/features/auth/viewModel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider).isLoading == true;

    ref.listen(authViewmodelProvider, (previous, next) {
      next.when(
        data: (data) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        error: (error, stackTrace) => showSnackBar(context, error.toString()),
        loading: () => const Loader(),
      );
    });

    return isLoading
        ? Loader()
        : Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignIn',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomField(hintText: 'Email', controller: emailController),
                    SizedBox(height: 10),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      btnText: 'Sign in',
                      onTap: () async {
                        final res = await AuthRemoteRepository().login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        final result = switch (res) {
                          Left(value: final l) => l,
                          Right(value: final r) => r,
                        };
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account ? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'sign up',
                              style: TextStyle(
                                color: AppPallate.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
