import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class FirebaseErrorMapper {
  static String getRegisterErrorMessage(BuildContext context, String code) {
    final loc = AppLocalizations.of(context)!;
    switch (code) {
      case 'email-already-in-use':
        return loc.email_already_registered;
      case 'invalid-email':
        return loc.invalid_email;
      case 'weak-password':
        return loc.weak_password;
      case 'network-request-failed':
        return loc.networkErrorMessage;
      default:
        return loc.something_went_wrong;
    }
  }
}
