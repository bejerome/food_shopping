import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/providers/site_provider.dart';
import 'package:camping_fanatics/ui/widgets/item_card.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class FruitAppCartView extends StatelessWidget {
  final TabController tabController;
  FruitAppCartView(this.tabController);

  @override
  Widget build(BuildContext context) {
    Widget cartItems = Provider.of<SiteProvider>(context).createShoppingItems();
    final appBar = TabBar(
      controller: tabController,
      indicatorColor: Colors.transparent,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey.withOpacity(0.6),
      isScrollable: true,
      tabs: <Widget>[
        Tab(
          child: TabText.tabText1,
        ),
        Tab(
          child: TabText.tabText2,
        ),
        Tab(
          child: TabText.tabText3,
        ),
        Tab(
          child: TabText.tabText4,
        ),
        Tab(
          child: TabText.tabText4,
        ),
      ],
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          appBar,
          SizedBox(
            height: 10.0,
          ),
          cartItems,
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
