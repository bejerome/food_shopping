import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/ui/widgets/item_card.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';

class SiteProvider extends ChangeNotifier {
  Widget screen;
  bool checkBoxStatus;
  UserModel saveUser;
  List<Fruit> fruits = [];
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

  void addItem(Fruit fruit) {
    this.fruits.add(fruit);
    // notifyListeners();
  }

  Widget createShoppingItems() {
    List<Widget> result = [];
    for (var i = 0; i < this.fruits.length; i++) {
      result.add(ItemCard(shoppingItem: this.fruits[i]));
    }
    return Column(children: result);
  }

  Widget createVegetableItems(_name) {
    List<Widget> result = [];
    var items = fruits.where((element) => element.type == _name);
    for (var i = 0; i < items.length; i++) {
      result.add(ItemCard(shoppingItem: this.fruits[i]));
    }
    return Column(children: result);
  }
}
