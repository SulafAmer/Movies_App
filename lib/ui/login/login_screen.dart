import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/langauge_toggle.dart';
import 'package:movies_app/ui/login/widgets/outlined_button_widget.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';
import '../../utils/size_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localeKeys = AppLocalizations.of(context)!;
    var langProvider = Provider.of<AppLanguageProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(17),
            vertical: context.scaleHeight(context.scaleHeight(67)),
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.appLogo,
                      height: context.scaleHeight(118),
                      width: context.scaleWidth(121),
                    ),
                  ),

                  SizedBox(height: context.scaleHeight(69)),

                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      hintDisplayedTxt: localeKeys.email,
                      prefIcon: SvgPicture.asset(AppImages.emailIcon),
                      prefixHeight: context.scaleHeight(25),
                      prefixWidth: context.scaleWidth(31),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      hintDisplayedTxt: localeKeys.password,
                      prefIcon: SvgPicture.asset(AppImages.lockIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                      sufIcon: SvgPicture.asset(AppImages.eyeOffIcon),
                      suffixHeight: context.scaleHeight(30),
                      suffixWidth: context.scaleWidth(30),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(8)),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.forgetPasswordScreenRouteName);
                        },
                        child: Text(
                          localeKeys.forgetPassword,
                          style: AppStyles.regular14Yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(48)),
                  Center(
                    child: SizedBox(
                      height: context.scaleHeight(56),
                      child: ElevatedButtonWidget(
                        onTab: () {
                          onLogin(context);
                        },
                        buttonText: localeKeys.loginButton,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        localeKeys.noAccount,
                        style: AppStyles.regular14White,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.registerScreenRouteName,
                          );
                        },
                        child: Text(
                          localeKeys.createAccount,
                          style: AppStyles.blackFont14Yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(22)),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          endIndent: 5,
                          height: 2,
                          thickness: 1,
                          color: AppColors.yellowColor,
                          indent: 5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          localeKeys.or,
                          style: AppStyles.regular15Yellow,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          endIndent: 5,
                          height: 2,
                          thickness: 1,
                          color: AppColors.yellowColor,
                          indent: 5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(22)),
                  OutlinedButtonWidget(
                    onTap: onLoginWithGoogle,
                    text: localeKeys.loginWithGoogle,

                    prefixIcon: langProvider.appLanguage == 'en'
                        ? SvgPicture.asset(
                            AppImages.googleLogo,
                            width: 26,
                            height: 26,
                          )
                        : null,
                  ),
                  SizedBox(height: context.scaleWidth(22)),

                  Center(child: LanguageToggle()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.homeScreenRouteName);
  }

  void onLoginWithGoogle() {}
}
