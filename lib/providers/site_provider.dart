import 'package:shopping_list/models/fruits.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/ui/widgets/item_card.dart';
import 'package:shopping_list/utils/utils.dart';
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

  Widget createShoppingItems({String cat = ""}) {
    List<Widget> result = [];
    switch (cat) {
      case "Dairy":
        result = createAllShoppingItems();
        break;
      case "fruits":
        result = createVegetableItems();
        break;
      default:
        createAllShoppingItems();
    }
    for (var i = 0; i < this.fruits.length; i++) {
      result.add(ItemCard(shoppingItem: this.fruits[i]));
    }
    return Column(children: result);
  }

  List<Widget> createAllShoppingItems() {
    List<Widget> result = [];
    for (var i = 0; i < this.fruits.length; i++) {
      result.add(ItemCard(shoppingItem: this.fruits[i]));
    }
    return result;
  }

  List<Widget> createVegetableItems() {
    List<Widget> result = [];
    var items =
        fruits.where((element) => element.type == "fruit_vegetables").toList();
    for (var i = 0; i < items.length; i++) {
      result.add(ItemCard(shoppingItem: items[i]));
    }
    return result;
  }
}
