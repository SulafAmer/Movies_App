import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/auth/auth_cubit.dart';
import 'package:movies_app/auth/auth_states.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/langauge_toggle.dart';
import 'package:movies_app/ui/login/widgets/outlined_button_widget.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';
import '../../utils/size_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  void onLogin() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    var localeKeys = AppLocalizations.of(context)!;
    var langProvider = Provider.of<AppLanguageProvider>(context);
    bool isPasswordVisible = false;

    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: BlocListener<AuthCubit,AuthStates>(
            listener: (BuildContext context, state) {
              if (state is AuthLoadingState) {
                DialogUtils.showLoading(
                  context: context,
                  loadingText: 'Loading ...',
                );
              }
              if (state is AuthSuccessState) {
                DialogUtils.hideLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: localeKeys.success,
                  message: localeKeys.login_successfully,
                  posActionName: localeKeys.ok,
                  posAction: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.homeScreenRouteName,
                    );
                  },
                );
              }
              if (state is AuthErrorState) {
                DialogUtils.hideLoading(context: context);
                DialogUtils.showMessage(
                  context: context,
                  title: localeKeys.error,
                  message: (state.errorMessage),
                  posActionName: localeKeys.ok,
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleWidth(17),
                vertical: context.scaleHeight(context.scaleHeight(67)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(text.trim())) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },

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
                          controller: passwordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Password ';
                            }
                            if (text.length < 6) {
                              return 'Please Enter Password Not Less Than 6 Characters';
                            }
                            return null;
                          },
                          hintDisplayedTxt: localeKeys.password,
                          prefIcon: SvgPicture.asset(AppImages.lockIcon),
                          prefixHeight: context.scaleHeight(30),
                          prefixWidth: context.scaleWidth(26),
                          obscure:   isPasswordVisible ,
                          suffixHeight: context.scaleHeight(30),
                          suffixWidth: context.scaleWidth(30),
                          sufIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.remove_red_eye_rounded
                                  : Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(8)),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgetPasswordScreenRouteName,
                              );
                            },
                            child: Text(
                              localeKeys.forgetPassword,
                              style: AppStyles.regular14Yellow,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.scaleHeight(25)),
                      Center(
                        child: SizedBox(
                          height: context.scaleHeight(56),
                          child: ElevatedButtonWidget(
                            onTab: () {
                              onLogin();
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
        ),
      );
  }

  void onLoginWithGoogle() {
    context.read<AuthCubit>().loginWithGoogle();
  }
  String getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return AppLocalizations.of(context)!.user_not_found;

      case 'wrong-password':
        return AppLocalizations.of(context)!.wrong_password;

      case 'invalid-email':
        return AppLocalizations.of(context)!.invalid_email;

      case 'invalid-credential':
        return AppLocalizations.of(context)!.invalid_credential;


      case 'network-request-failed':
        return AppLocalizations.of(context)!.network_error;

      default:
        return AppLocalizations.of(context)!.something_went_wrong;
    }
  }
}
