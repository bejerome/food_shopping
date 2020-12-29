import 'dart:io' as io;

import 'package:camping_fanatics/models/fruits.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class ItemCard extends StatefulWidget {
  final Fruit shoppingItem;
  ItemCard({this.shoppingItem});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Future<Image> getDevIcon(String path) async {
    return rootBundle.load(path).then((value) {
      return Image.memory(value.buffer.asUint8List());
    }).catchError((_) {
      return Image.asset(
        "assets/images/avatar.png",
        height: 250.0,
      );
    });
  }

  Future<String> getImage(String path) async {
    try {
      await rootBundle.loadString(path);
      return widget.shoppingItem.image;
    } catch (_) {
      return 'assets/images/avatar.png';
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
        color: Colors.transparent,
        // elevation: 20.0,
        // shadowColor: Colors.grey,
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
                child: FutureBuilder(
                  future: getDevIcon(widget.shoppingItem.image),
                  builder:
                      (BuildContext context, AsyncSnapshot<Image> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return snapshot.data;
                    else
                      return Image.asset(
                        'assets/images/avatar.png',
                      );
                  },
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
