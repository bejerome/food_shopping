import 'package:shopping_list/providers/site_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FruitAppCartView extends StatelessWidget {
  final TabController tabController;
  FruitAppCartView(this.tabController);

  @override
  Widget build(BuildContext context) {
    Widget cartItems = Provider.of<SiteProvider>(context).createShoppingItems();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(child: cartItems),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
