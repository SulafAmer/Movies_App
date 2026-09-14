import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onTab;
  final String buttonText;

  const ElevatedButtonWidget({
    super.key,
    required this.onTab,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTab,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Text(
            buttonText,
            style: AppStyles.regular20Black,
          ),
        ),
      ),
    );
  }
}
