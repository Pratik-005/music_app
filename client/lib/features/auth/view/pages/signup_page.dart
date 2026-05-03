import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:music_app/core/theme/app_pallate.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:music_app/features/auth/view/pages/login_page.dart';
import 'package:music_app/features/auth/view/widgets/custom_field.dart';
import 'package:music_app/features/auth/view/widgets/gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
                'Signup',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomField(hintText: 'Name', controller: nameController),
              SizedBox(height: 10),
              CustomField(hintText: 'Email', controller: emailController),
              SizedBox(height: 10),
              CustomField(hintText: 'Password', controller: passwordController),
              SizedBox(height: 20),
              GradientButton(
                btnText: 'Sign up',
                onTap: () async {
                  final res = await AuthRemoteRepository().signup(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  final val = switch (res) {
                    Left(value: var l) => l,
                    Right(value: var r) => r.name,
                  };
                  print(val);
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account ? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Signin',
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
