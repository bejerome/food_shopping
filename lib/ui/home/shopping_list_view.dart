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
    var fruits = Provider.of<SiteProvider>(context).fruits;

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

    final cartItems = Provider.of<SiteProvider>(context).createShoppingItems();

    final cartValue = Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'A total of: ',
            style: TextStyle(
              color: Colors.grey.withOpacity(0.9),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.primaryFont,
            ),
          ),
          Text(
            '\$97.02',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.primaryFont,
            ),
          )
        ],
      ),
    );

    final btn = Column(
      children: <Widget>[
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(45.0),
          shadowColor: Colors.white,
          child: Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width / 4 * 3,
            decoration: BoxDecoration(
              color: Color(0XFF558948),
              borderRadius: BorderRadius.circular(45.0),
            ),
            child: Center(
              child: Text(
                'Settlement',
                style: TextStyle(
                  fontFamily: Fonts.primaryFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );

    final body = ListView(
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
    );

    return Scaffold(
      body: body,
    );
  }

  Widget _buildCartCard(Fruit fruit, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Material(
        elevation: 54.0,
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  fruit.image,
                  fit: BoxFit.cover,
                  height: 80.0,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fruit.name,
                            style: TextStyle(
                              fontFamily: Fonts.primaryFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'QTY',
                            style: TextStyle(
                              fontFamily: Fonts.primaryFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
