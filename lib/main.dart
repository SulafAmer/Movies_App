import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/auth/auth_cubit.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/providers/app_language_provider.dart';
import 'package:movies_app/ui/login/forget_password_screen.dart';
import 'package:movies_app/ui/login/login_screen.dart';
import 'package:movies_app/ui/login/register_screen.dart';
import 'package:movies_app/ui/screens/home_screen.dart';
import 'package:movies_app/ui/screens/profile/update_profile_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/firebase_utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSignIn.instance.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppLanguageProvider();
      },
      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login_screen',
      routes: {
        AppRoutes.loginScreenRouteName: (context) => BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child: LoginScreen(),
        ),
        AppRoutes.registerScreenRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetPasswordScreenRouteName: (context) =>
            ForgetPasswordScreen(),
        AppRoutes.updateProfileScreenRouteName: (context) =>
            UpdateProfileScreen(),
        AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
      },
      locale: Locale(langProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'),
      ],
    );
  }
}
