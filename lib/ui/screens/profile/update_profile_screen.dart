import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/login/login_screen.dart';
import 'package:movies_app/ui/screens/profile/widgets/profile_text_field.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String? currentName;
  final String? currentPhone;
  final String? currentAvatar;

  const UpdateProfileScreen({
    super.key,
    this.currentName,
    this.currentPhone,
    this.currentAvatar,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late String selectedAvatar;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.currentAvatar ?? AppImages.avatar1;
    nameController = TextEditingController(
      text: widget.currentName ?? "John Safwat",
    );
    phoneController = TextEditingController(
      text: widget.currentPhone ?? "01200000000",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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

  void _showDeleteConfirmationDialog() {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkGrayColor,
        title: Text(loc.deleteAccount, style: AppStyles.bold20Yellow),
        content: Text(
          loc.deleteConfirmMessage,
          style: AppStyles.regular16White,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel, style: AppStyles.regular16White),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
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

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.scaleHeight(16)),

              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.yellowColor),
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

              Text(loc.resetPassword, style: AppStyles.regular16White),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: context.scaleHeight(56),
                child: ElevatedButton(
                  onPressed: _showDeleteConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.scaleWidth(16),
                      ),
                    ),
                  ),
                  child: Text(
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
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'avatar': selectedAvatar,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.scaleWidth(16),
                      ),
                    ),
                  ),
                  child: Text(
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
  }
}
