import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../../../providers/app_language_provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      builder: (context, langProvider, _) {
        return AnimatedToggleSwitch<String>.rolling(
          current: langProvider.appLanguage,
          values: const ['en', 'ar'],
          onChanged: (value) => langProvider.changeLanguage(value),
          iconBuilder: (value, foreground) {
            final path = value == 'en'
                ? 'assets/images/us_flag.png'
                : 'assets/images/eg_flag.png';
            return ClipOval(
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            );
          },
          style: ToggleStyle(
            backgroundColor: Colors.transparent,
            borderColor: Colors.orange,
            borderRadius: BorderRadius.circular(30),
            indicatorColor: Colors.orange,
          ),
          styleBuilder: (value) => ToggleStyle(
            indicatorBorderRadius: BorderRadius.circular(30),
          ),
          borderWidth: 1.5,
          height: 40,
          indicatorSize: const Size(38, 32),
        );
      },
    );
  }
}