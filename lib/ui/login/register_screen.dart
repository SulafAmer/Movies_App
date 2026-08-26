import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  int selectedIndex = 0;
  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
  ];

  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localeKeys = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: AppColors.yellowColor,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
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
              key: _formKey,
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

                  // حقل الاسم
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      controller: nameController,
                      hintDisplayedTxt: localeKeys.name,
                      prefIcon: SvgPicture.asset(AppImages.nameIcon),
                      prefixHeight: context.scaleHeight(35),
                      prefixWidth: context.scaleWidth(31),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك ادخل الاسم';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),

                  // حقل الإيميل
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      controller: emailController,
                      hintDisplayedTxt: localeKeys.email,
                      prefIcon: SvgPicture.asset(AppImages.emailIcon),
                      prefixHeight: context.scaleHeight(25),
                      prefixWidth: context.scaleWidth(31),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك ادخل البريد الإلكتروني';
                        }
                        final emailRegex =
                        RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'البريد الإلكتروني غير صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),

                  // حقل الباسورد
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      controller: passwordController,
                      hintDisplayedTxt: localeKeys.password,
                      obscureText: obscurePassword,
                      prefIcon: SvgPicture.asset(AppImages.lockIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                      sufIcon: SvgPicture.asset(AppImages.eyeOffIcon),
                      suffixHeight: context.scaleHeight(30),
                      suffixWidth: context.scaleWidth(30),
                      onSuffixTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),

                  // حقل تأكيد الباسورد
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      controller: confirmPasswordController,
                      hintDisplayedTxt: localeKeys.confirmPassword,
                      obscureText: obscureConfirmPassword,
                      prefIcon: SvgPicture.asset(AppImages.lockIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                      sufIcon: SvgPicture.asset(AppImages.eyeOffIcon),
                      suffixHeight: context.scaleHeight(30),
                      suffixWidth: context.scaleWidth(30),
                      onSuffixTap: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أكد كلمة المرور';
                        }
                        if (value != passwordController.text) {
                          return 'كلمة المرور غير متطابقة';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(22)),

                  // حقل التليفون
                  SizedBox(
                    width: double.infinity,
                    height: context.scaleHeight(56),
                    child: TextFieldWidget(
                      controller: phoneController,
                      hintDisplayedTxt: localeKeys.phoneNumber,
                      prefIcon: SvgPicture.asset(AppImages.phoneIcon),
                      prefixHeight: context.scaleHeight(30),
                      prefixWidth: context.scaleWidth(26),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: context.scaleHeight(22)),
                  Center(
                    child: SizedBox(
                      height: context.scaleHeight(56),
                      child: isLoading
                          ? CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      )
                          : ElevatedButtonWidget(
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

  Future<void> onCreatAccount(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatar': avatars[selectedIndex],
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        Navigator.of(context).pushNamed(AppRoutes.homeScreenRouteName);
      }
    } on FirebaseAuthException catch (e) {
      print('FIREBASE AUTH ERROR: ${e.code} - ${e.message}');
      String message = 'حدث خطأ، حاول مرة أخرى';
      if (e.code == 'email-already-in-use') {
        message = 'هذا البريد الإلكتروني مستخدم بالفعل';
      } else if (e.code == 'weak-password') {
        message = 'كلمة المرور ضعيفة جدًا';
      } else if (e.code == 'invalid-email') {
        message = 'صيغة البريد الإلكتروني غير صحيحة';
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      print('GENERAL ERROR: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع، تحقق من الاتصال بالإنترنت')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}