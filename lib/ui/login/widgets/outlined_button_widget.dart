
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../../utils/size_utils.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Widget? prefixIcon;

  const OutlinedButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.yellowColor,
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              width: 50,
              child:
                  prefixIcon == null
                      ? const SizedBox()
                      : Center(child: prefixIcon),
            ),

            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: AppStyles.regular16Black
                  ),
                ),
              ),


            const SizedBox(width: 36),
          ],
        ),
      ),
    );
  }
}
