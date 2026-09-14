import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/auth/auth_cubit.dart';
import 'package:movies_app/auth/auth_states.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/langauge_toggle.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/firebase_error_mapper.dart';
import 'package:movies_app/utils/validators.dart';

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
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
              DialogUtils.showLoading(
                context: context,
                loadingText: localeKeys.loading,
              );
            } else if (state is RegisterSuccessState) {
              DialogUtils.hideLoading(context: context);
              DialogUtils.showMessage(
                context: context,
                title: localeKeys.success,
                message: localeKeys.registered_successfully,
                posActionName: localeKeys.ok,
                posAction: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.homeScreenRouteName,
                        (route) => false,
                  );
                },
              );
            } else if (state is RegisterErrorState) {
              DialogUtils.hideLoading(context: context);
              final message = FirebaseErrorMapper.getRegisterErrorMessage(
                context,
                state.errorCode,
              );
              DialogUtils.showMessage(
                context: context,
                title: localeKeys.error,
                message: message,
                posActionName: localeKeys.ok,
              );
            }
          },
          builder: (context, state) {
            return Padding(
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
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: context.scaleHeight(56),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFieldWidget(
                            hintDisplayedTxt: localeKeys.name,
                            controller: nameController,
                            validator: (value) =>
                                Validators.validateName(context, value),
                            prefIcon: SvgPicture.asset(AppImages.nameIcon),
                            prefixHeight: context.scaleHeight(35),
                            prefixWidth: context.scaleWidth(31),
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(22)),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: context.scaleHeight(56),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFieldWidget(
                            hintDisplayedTxt: localeKeys.email,
                            controller: emailController,
                            validator: (value) =>
                                Validators.validateEmail(context, value),
                            prefIcon: SvgPicture.asset(AppImages.emailIcon),
                            prefixHeight: context.scaleHeight(25),
                            prefixWidth: context.scaleWidth(31),
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(22)),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: context.scaleHeight(56),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFieldWidget(
                            hintDisplayedTxt: localeKeys.password,
                            controller: passwordController,
                            obscure: obscurePassword,
                            validator: (value) =>
                                Validators.validatePassword(context, value),
                            prefIcon: SvgPicture.asset(AppImages.lockIcon),
                            prefixHeight: context.scaleHeight(30),
                            prefixWidth: context.scaleWidth(26),
                            sufIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              child: SvgPicture.asset(AppImages.eyeOffIcon),
                            ),
                            suffixHeight: context.scaleHeight(30),
                            suffixWidth: context.scaleWidth(30),
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(22)),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: context.scaleHeight(56),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFieldWidget(
                            hintDisplayedTxt: localeKeys.confirmPassword,
                            controller: confirmPasswordController,
                            obscure: obscureConfirmPassword,
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                  context,
                                  value,
                                  passwordController.text,
                                ),
                            prefIcon: SvgPicture.asset(AppImages.lockIcon),
                            prefixHeight: context.scaleHeight(30),
                            prefixWidth: context.scaleWidth(26),
                            sufIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureConfirmPassword =
                                  !obscureConfirmPassword;
                                });
                              },
                              child: SvgPicture.asset(AppImages.eyeOffIcon),
                            ),
                            suffixHeight: context.scaleHeight(30),
                            suffixWidth: context.scaleWidth(30),
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(22)),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: context.scaleHeight(56),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFieldWidget(
                            hintDisplayedTxt: localeKeys.phoneNumber,
                            controller: phoneController,
                            validator: (value) =>
                                Validators.validatePhone(context, value),
                            prefIcon: SvgPicture.asset(AppImages.phoneIcon),
                            prefixHeight: context.scaleHeight(30),
                            prefixWidth: context.scaleWidth(26),
                          ),
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
            );
          },
        ),
      ),
    );
  }

  void onCreatAccount(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: phoneController.text.trim(),
        avatar: avatars[selectedIndex],
      );
    }
  }
}