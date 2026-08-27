import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/toast_utils.dart';
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localeKeys=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.yellowColor),
        ),
        title: Text(
          localeKeys.forgetPasswordTitle,
          style: AppStyles.regular16Yellow,
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                AppImages.forgetPasswordImage,
                width: context.scaleWidth(430),
                height: context.scaleHeight(430),
              ),
            ),
            SizedBox(height: context.scaleHeight(24),),
            SizedBox(
              width: double.infinity,
              height: context.scaleHeight(56),
              child: TextFieldWidget(
                hintDisplayedTxt: localeKeys.email,
                prefIcon: SvgPicture.asset(AppImages.emailIcon),
                prefixHeight: context.scaleHeight(25),
                prefixWidth: context.scaleWidth(31),
                controller: emailController,
              ),
        
            ),
            SizedBox(height: context.scaleHeight(24),),
        
            Center(
              child: SizedBox(
                height: context.scaleHeight(56),
                child: ElevatedButtonWidget(
                  onTab: onVerifyEmail,
                  buttonText: localeKeys.verifyEmailTitle,
                ),
              ),
            ),
        
        
          ],
        ),
      ),
    );
  }

  void onVerifyEmail() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text)
        .then((value) {
      ToastUtils.showToastMessage(
        message: "email sent successfully",
        backGroundColor: Colors.green,
        textColor: AppColors.whiteColor,
      );
    }).catchError((error) {
      ToastUtils.showToastMessage(
        message: error.toString(),
        backGroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
      );
    });
  }
}
