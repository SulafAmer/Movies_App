import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class Validators {
  static String? validateName(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) return loc.please_enter_name;
    if (value.trim().length < 3) return loc.nameTooShort;
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) return loc.please_enter_email;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return loc.please_enter_valid_email;
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) return loc.phoneRequired;
    final phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
    if (!phoneRegex.hasMatch(value.trim())) return loc.phoneInvalid;
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) return loc.please_enter_password;
    if (value.length < 6) return loc.password_too_short;
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? value,
    String password,
  ) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty)
      return loc.please_enter_confirm_password;
    if (value != password) return loc.passwords_do_not_match;
    return null;
  }
}
