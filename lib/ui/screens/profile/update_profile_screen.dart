import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/profile/cubit/update_profile_cubit.dart';
import 'package:movies_app/ui/screens/profile/cubit/update_profile_states.dart';
import 'package:movies_app/ui/screens/profile/widgets/profile_text_field.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit()..getUserData(),
      child: const _UpdateProfileView(),
    );
  }
}

class _UpdateProfileView extends StatefulWidget {
  const _UpdateProfileView();

  @override
  State<_UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<_UpdateProfileView> {
  late String selectedAvatar;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  bool isDataLoaded = false;

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

  @override
  void initState() {
    super.initState();
    selectedAvatar = AppImages.avatar1;
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _fillFieldsFromUser(user) {
    nameController.text = user.name;
    phoneController.text = user.phone;
    if (user.avatar.isNotEmpty) {
      selectedAvatar = user.avatar;
    }
  }

  void _showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(24),
            vertical: context.scaleHeight(24),
          ),
          padding: EdgeInsets.all(context.scaleWidth(20)),
          height: context.scaleHeight(400),
          decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(context.scaleWidth(24)),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: context.scaleWidth(12),
              mainAxisSpacing: context.scaleHeight(12),
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final avatarPath = avatars[index];
              bool isSelected = avatarPath == selectedAvatar;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedAvatar = avatarPath);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yellowColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(context.scaleWidth(16)),
                    border: Border.all(
                      color: AppColors.yellowColor,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.scaleWidth(14)),
                    child: Padding(
                      padding: EdgeInsets.all(context.scaleWidth(6)),
                      child: Image.asset(avatarPath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext cubitContext) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkGrayColor,
        title: Text(loc.deleteAccount, style: AppStyles.bold20Yellow),
        content: Text(
          loc.deleteConfirmMessage,
          style: AppStyles.regular16White,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(loc.cancel, style: AppStyles.regular16White),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubitContext.read<UpdateProfileCubit>().deleteAccount();
            },
            child: Text(
              loc.deleteAccount,
              style: AppStyles.bold20Yellow.copyWith(color: AppColors.redColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
      listener: (context, state) {
        if (state is GetUserDataSuccessState && !isDataLoaded) {
          isDataLoaded = true;
          _fillFieldsFromUser(state.user);
        } else if (state is GetUserDataErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is UpdateUserDataSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(loc.updateData)));
          Navigator.pop(context);
        } else if (state is UpdateUserDataErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is DeleteAccountSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginScreenRouteName,
            (route) => false,
          );
        } else if (state is DeleteAccountErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final isLoadingUserData = state is GetUserDataLoadingState;
        final isSaving = state is UpdateUserDataLoadingState;
        final isDeleting = state is DeleteAccountLoadingState;

        return Scaffold(
          backgroundColor: AppColors.blackColor,
          body: SafeArea(
            child: isLoadingUserData
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.scaleHeight(16)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.yellowColor,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  loc.pickAvatarTitle,
                                  style: AppStyles.bold20Yellow,
                                ),
                              ),
                            ),
                            SizedBox(width: context.scaleWidth(48)),
                          ],
                        ),
                        SizedBox(height: context.scaleHeight(32)),
                        Center(
                          child: GestureDetector(
                            onTap: _showAvatarBottomSheet,
                            child: CircleAvatar(
                              radius: context.scaleWidth(60),
                              backgroundColor: AppColors.yellowColor,
                              child: CircleAvatar(
                                radius: context.scaleWidth(57),
                                backgroundImage: AssetImage(selectedAvatar),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.scaleHeight(32)),
                        ProfileTextField(
                          iconPath: AppImages.nameIcon,
                          controller: nameController,
                          hint: loc.name,
                        ),
                        SizedBox(height: context.scaleHeight(16)),
                        ProfileTextField(
                          iconPath: AppImages.phoneIcon,
                          controller: phoneController,
                          hint: loc.phoneNumber,
                        ),
                        SizedBox(height: context.scaleHeight(16)),
                        Text(
                          loc.resetPassword,
                          style: AppStyles.regular16White,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: context.scaleHeight(56),
                          child: ElevatedButton(
                            onPressed: isDeleting
                                ? null
                                : () => _showDeleteConfirmationDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.scaleWidth(16),
                                ),
                              ),
                            ),
                            child: isDeleting
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    loc.deleteAccount,
                                    style: AppStyles.regular20White,
                                  ),
                          ),
                        ),
                        SizedBox(height: context.scaleHeight(12)),
                        SizedBox(
                          width: double.infinity,
                          height: context.scaleHeight(56),
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateUserData(
                                          name: nameController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          avatar: selectedAvatar,
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.yellowColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.scaleWidth(16),
                                ),
                              ),
                            ),
                            child: isSaving
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    loc.updateData,
                                    style: AppStyles.regular20White.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: context.scaleHeight(24)),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
