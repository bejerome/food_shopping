import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:flutter/services.dart';

class ItemCard extends StatefulWidget {
  final Fruit shoppingItem;
  ItemCard({this.shoppingItem});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Future<Widget> getDevIcon(String path) async {
    try {
      await rootBundle.load(path);
      return Image.asset(path);
    } catch (_) {
      return SizedBox.shrink();
    }
  }

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
        elevation: 20.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          height: 90.0,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.shoppingItem.name,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.shoppingItem.quantity,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            widget.shoppingItem.amount,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 20.0,
                            ),
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
