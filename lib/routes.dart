import 'package:camping_fanatics/ui/home/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:camping_fanatics/ui/auth/register_screen.dart';
import 'package:camping_fanatics/ui/auth/sign_in_screen.dart';
import 'package:camping_fanatics/ui/setting/setting_screen.dart';
import 'package:camping_fanatics/ui/splash/splash_screen.dart';
import 'package:camping_fanatics/ui/home/main_screen.dart';
import 'package:camping_fanatics/ui/user/edit_user_profile.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String todo = '/home';
  static const String setting = '/setting';
  static const String main = '/main';
  static const String edit_profile = '/profile';
  static const String calendar = '/calendar';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => SignInScreen(),
    register: (BuildContext context) => RegisterScreen(),
    setting: (BuildContext context) => SettingScreen(),
    main: (BuildContext context) => MainScreen(),
    edit_profile: (BuildContext context) => UserProfileScreen(),
    calendar: (BuildContext context) => CalendarPopupView(),
  };
}
