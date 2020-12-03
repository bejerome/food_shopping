import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final Fruit shoppingItem;
  ItemCard({this.shoppingItem});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
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
                  widget.shoppingItem.image,
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
                            widget.shoppingItem.name,
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
                            widget.shoppingItem.quantity,
                            style: TextStyle(
                              fontFamily: Fonts.primaryFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            widget.shoppingItem.amount,
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
