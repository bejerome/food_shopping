import 'dart:core';
import 'dart:ui';

import 'package:adv_fab/adv_fab.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:shopping_list/models/fruits.dart';
import 'package:shopping_list/providers/site_provider.dart';
import 'package:shopping_list/utils/items.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:trie/trie.dart';

class ShoppingForm extends StatefulWidget {
  final AdvFabController formController;
  ShoppingForm({this.formController});
  @override
  ShoppingFormState createState() => ShoppingFormState();
}

class ShoppingFormState extends State<ShoppingForm> {
  String currentText = "";
  List<String> added = [];
  SimpleAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> _formKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteFormKey =
      new GlobalKey();
  int tag = 0;
  List<String> options = ['Quantity', 'Lbs', 'Box', 'bag'];
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  String valueStored = "qty";
  String amountLabel = "qty";
  String itemType;
  List results = ShoppingItem.generateList();
  List<String> allItemsList = [];
  @override
  void initState() {
    super.initState();
    results.forEach((element) {
      allItemsList.add(element.name);
    });
  }

  String storeValue(index) {
    switch (index) {
      case 0:
        return "qty";
        break;
      case 1:
        return "lbs";
        break;
      case 2:
        return "box";
        break;
      case 3:
        return "bag";
        break;
      default:
        return null;
    }
  }

  void updateItemList() {
    Provider.of<SiteProvider>(context, listen: false).addItem(
      Fruit(
          name: "${itemNameController.text}",
          amount: "${itemQuantityController.text}",
          image: "assets/images/${itemNameController.text}.png",
          quantity: "$valueStored",
          type: ShoppingItem.getCategories('${itemNameController.text}').type,
          color: Color(0XFF558948),
          rating: 4.5),
    );
  }

  List<String> getSuggestions(value) {
    Trie trie = new Trie.list(allItemsList);
    return trie.getAllWordsWithPrefix(value);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: itemNameController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    return getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(
                        suggestion,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    itemNameController.text = suggestion;
                  },
                ),
                Container(
                  child: ChipsChoice<int>.single(
                    direction: Axis.horizontal,
                    choiceActiveStyle: C2ChoiceStyle(
                      elevation: 20,
                      pressElevation: 1,
                      borderColor: Colors.transparent,
                      color: Colors.green,
                      labelStyle: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    choiceStyle: C2ChoiceStyle(
                      elevation: 5,
                      color: Colors.orange,
                      borderColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    value: tag,
                    onChanged: (val) => {
                      valueStored = storeValue(val),
                      setState(() => tag = val),
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: itemQuantityController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: valueStored,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    isExtended: true,
                    elevation: 15,
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onPressed: () {
                      print("Item: ${itemNameController.text} ");
                      print("$valueStored: ${itemQuantityController.text} ");
                      print(ShoppingItem.getCategories(
                              '${itemNameController.text}')
                          .type);
                      widget.formController.collapseFAB();
                      updateItemList();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
