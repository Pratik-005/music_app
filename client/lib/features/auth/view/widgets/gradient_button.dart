import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallate.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppPallate.gradient1, AppPallate.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: AppPallate.transparentColor,
          backgroundColor: AppPallate.transparentColor,
          fixedSize: Size(395, 55),
        ),
        onPressed: () {},
        child: Text(
          'Signup',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
