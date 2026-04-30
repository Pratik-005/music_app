import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallate.dart';

class GradientButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  const GradientButton({super.key, required this.btnText, required this.onTap});

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
        onPressed: () => onTap(),
        child: Text(
          btnText,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
