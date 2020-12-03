import 'package:flutter/material.dart';
import 'package:camping_fanatics/utils/utils.dart';

class Fruit {
  int id;
  String name,
      desc =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id neque libero. Donec finibus sem viverra, luctus nisi ac, semper enim. Vestibulum in mi feugiat, mattis erat suscipit, fermentum quam. Mauris non urna sed odio congue rhoncus.',
      amount,
      image,
      quantity;
  Color color;
  double rating;

  Fruit(this.id, this.name, this.amount, this.image, this.quantity, this.color,
      this.rating);
}

// final List<Fruit> fruits = [
//   Fruit(1, 'avocado', '18.78', ImageAssetPath.avocadoImage, '89',
//       Color(0XFF558948), 4.5),
//   Fruit(2, 'Grape', '65.36', ImageAssetPath.grapeImage, '12', Color(0XFF8FC320),
//       4.9),
//   Fruit(3, 'orange', '12.88', ImageAssetPath.orangeImage, '75',
//       Color(0XFFef9b13), 5.0),
//   Fruit(4, 'Special apple fresh from the southern califonia farm in texas USA',
//       '13.88', ImageAssetPath.appleImage, '80', Color(0XFFef794f), 4.4),
//   Fruit(5, 'lemon', '15.00', ImageAssetPath.lemonImage, '75', Color(0XFFead04d),
//       5.0),
// ];
