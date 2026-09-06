import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/login/widgets/elevated_button_widget.dart';
import 'package:movies_app/ui/login/widgets/text_field_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/toast_utils.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart'; // الـ Loading ويدجت بتاع مشروعكم
import '../../../di/injection.dart'; // مسار الـ GetIt في مشروعك
import 'cubit/forget_password_cubit.dart';
import 'cubit/forget_password_states.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose(); // تنظيف الذاكرة عند إغلاق الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localeKeys = AppLocalizations.of(context)!;

    return BlocProvider(
      // جلب الـ Cubit تلقائياً من الـ GetIt
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: Scaffold(
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
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ToastUtils.showToastMessage(
                message: "Email sent successfully",
                backGroundColor: Colors.green,
                textColor: AppColors.whiteColor,
              );
              Navigator.pop(context); // الرجوع لشاشة الـ Login تلقائياً بعد النجاح
            } else if (state is ForgotPasswordError) {
              ToastUtils.showToastMessage(
                message: state.errorMessage,
                backGroundColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
            child: SingleChildScrollView( // لحماية الشاشة من الكيبورد إذا ظهر
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.forgetPasswordImage,
                      width: context.scaleWidth(430),
                      height: context.scaleHeight(430),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(24)),
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
                  SizedBox(height: context.scaleHeight(24)),

                  // استخدام BlocBuilder للتحكم في شكل الزرار أثناء الـ Loading
                  Center(
                    child: SizedBox(
                      height: context.scaleHeight(56),
                      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                        builder: (context, state) {
                          if (state is ForgotPasswordLoading) {
                            return const Center(child: MainLoadingWidget());
                          }
                          return ElevatedButtonWidget(
                            onTab: () {
                              // إرسال الإيميل للكوبيت عند الضغط
                              context.read<ForgotPasswordCubit>().sendPasswordResetEmail(
                                emailController.text,
                              );
                            },
                            buttonText: localeKeys.verifyEmailTitle,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
