import 'package:flutter/material.dart';

class Fruit {
  String name,
      desc =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id neque libero. Donec finibus sem viverra, luctus nisi ac, semper enim. Vestibulum in mi feugiat, mattis erat suscipit, fermentum quam. Mauris non urna sed odio congue rhoncus.',
      amount,
      image,
      quantity,
      type;
  Color color;
  double rating;

  Fruit(
      {this.name,
      this.amount,
      this.image,
      this.quantity,
      this.type,
      this.color,
      this.rating});
}
