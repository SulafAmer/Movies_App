import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/langauge_toggle.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../utils/app_routes.dart';
import '../../utils/size_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedIndex = 0;
  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
  ];

  @override
  Widget build(BuildContext context) {
    var localeKeys = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: AppColors.yellowColor,
            onPressed: () { Navigator.pop(context); },
            icon: Icon(Icons.arrow_back),),
          title: Text(
            localeKeys.registerTitle,
            style: AppStyles.regular16Yellow,
          ),
          centerTitle: true,
          backgroundColor: AppColors.blackColor,
        ),
        backgroundColor: AppColors.blackColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(17),
            vertical: context.scaleHeight(context.scaleHeight(20)),
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: avatars.length,
                    itemBuilder: (context, index, realIndex) {
                      bool isSelected = index == selectedIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: isSelected
                            ? context.scaleWidth(200)
                            : context.scaleWidth(94),
                        height: isSelected
                            ? context.scaleHeight(180)
                            : context.scaleHeight(94),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(
                            image: AssetImage(avatars[index]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: context.scaleHeight(150),

                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      viewportFraction: 0.4,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      localeKeys.avatar,
                      style: AppStyles.regular16White,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(12)),
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      hintDisplayedTxt: localeKeys.name,
                      prefIcon: SvgPicture.asset(AppImages.nameIcon),
                      prefixHeight: context.scaleHeight(35),
                      prefixWidth: context.scaleWidth(31),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),
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
                  SizedBox(height: context.scaleHeight(22)),
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      hintDisplayedTxt: localeKeys.confirmPassword,
                      prefIcon: SvgPicture.asset(AppImages.lockIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                      sufIcon: SvgPicture.asset(AppImages.eyeOffIcon),
                      suffixHeight: context.scaleHeight(30),
                      suffixWidth: context.scaleWidth(30),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),

                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      hintDisplayedTxt: localeKeys.phoneNumber,
                      prefIcon: SvgPicture.asset(AppImages.phoneIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                    ),
                  ),

                  SizedBox(height: context.scaleHeight(22)),
                  Center(
                    child: SizedBox(
                      height: context.scaleHeight(56),
                      child: ElevatedButtonWidget(
                        onTab: () {
                          onCreatAccount(context);
                        },
                        buttonText: localeKeys.createAccount,
                      ),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        localeKeys.alreadyHaveAccount,
                        style: AppStyles.regular14White,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.loginScreenRouteName,
                          );
                        },
                        child: Text(
                          localeKeys.loginButton,
                          style: AppStyles.blackFont14Yellow,
                        ),
                      ),
                    ],
                  ),
                  Center(child: LanguageToggle()),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onCreatAccount(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.homeScreenRouteName);
  }
}
