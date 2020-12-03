import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/ui/widgets/item_card.dart';
import 'package:camping_fanatics/utils/utils.dart';
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

  void addItem(Fruit fruit) {
    fruits.add(fruit);
  }

  Widget createShoppingItems() {
    List<Widget> result = new List<Widget>();
    for (var i = 0; i < fruits.length - 1; i++) {
      result.add(ItemCard(shoppingItem: fruits[i]));
    }
    return Column(children: result);
  }

  List<Fruit> fruits = [
    // Fruit(1, 'avocado', '18.78', ImageAssetPath.avocadoImage, '89',
    //     Color(0XFF558948), 4.5),
    // Fruit(2, 'Grape', '65.36', ImageAssetPath.grapeImage, '12',
    //     Color(0XFF8FC320), 4.9),
    // Fruit(3, 'orange', '12.88', ImageAssetPath.orangeImage, '75',
    //     Color(0XFFef9b13), 5.0),
    // Fruit(4, 'Special apple', '13.88', ImageAssetPath.appleImage, '80',
    //     Color(0XFFef794f), 4.4),
    // Fruit(5, 'lemon', '15.00', ImageAssetPath.lemonImage, '75',
    //     Color(0XFFead04d), 5.0),
  ];
}
