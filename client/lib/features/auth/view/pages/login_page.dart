import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:music_app/core/theme/app_pallate.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:music_app/features/auth/view/pages/signup_page.dart';
import 'package:music_app/features/auth/view/widgets/custom_field.dart';
import 'package:music_app/features/auth/view/widgets/gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SignIn',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomField(hintText: 'Email', controller: emailController),
              SizedBox(height: 10),
              CustomField(hintText: 'Password', controller: passwordController),
              SizedBox(height: 20),
              GradientButton(
                btnText: 'Sign in',
                onTap: () async{
                  final res =  await AuthRemoteRepository().login(
                  email: emailController.text,
                  password: passwordController.text,
                );
                final result = switch(res){
                  Left(value : final l) => l ,
                  Right(value: final r) =>r
                }
                }
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage())),
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
