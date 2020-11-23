import 'package:camping_fanatics/models/user_model.dart';
import 'package:flutter/material.dart';

class SiteProvider extends ChangeNotifier {
  Widget screen;
  bool checkBoxStatus;
  UserModel saveUser;

  void navigateTo(Widget screen) {
    this.screen = screen;
    notifyListeners();
  }

  Widget get currentScreen {
    return screen;
  }

  void storeUserInfo(UserModel user) {
    this.saveUser = user;
  }

  get currentUser {
    return this.saveUser;
  }
}
