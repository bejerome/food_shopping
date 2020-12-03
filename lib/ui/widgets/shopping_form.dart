import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/providers/site_provider.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:provider/provider.dart';

class ShoppingForm extends StatefulWidget {
  @override
  ShoppingFormState createState() => ShoppingFormState();
}

class ShoppingFormState extends State<ShoppingForm> {
  String currentText = "";
  List<String> added = [];
  SimpleAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> _formKey = new GlobalKey();
  int tag = 0;
  List<String> options = ['Quantity', 'Lbs', 'Box', 'bag'];
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  String valueStored = "QTY";
  String amountLabel = "QTY";

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: ListTile(
                    title: TextFormField(
                      controller: itemNameController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: "Add Item",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),

                ListTile(
                  title: Container(
                    child: ChipsChoice<int>.single(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: ListTile(
                    title: TextFormField(
                      controller: itemQuantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: valueStored,
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 70,
                    width: 70,
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
                        setState(() {
                          Provider.of<SiteProvider>(context, listen: false)
                              .addItem(
                            Fruit(
                                int.parse(itemQuantityController.text),
                                "${itemNameController.text}",
                                "${itemQuantityController.text}",
                                ImageAssetPath.avocadoImage,
                                "$valueStored",
                                Color(0XFF558948),
                                4.5),
                          );
                        });
                      },
                    ),
                  ),
                ),

                // SimpleAutoCompleteTextField(
                //   key: _formKey,
                //   decoration: new InputDecoration(errorText: "Beans"),
                //   controller: TextEditingController(text: "Starting Text"),
                //   suggestions: suggestions,
                //   textChanged: (text) => currentText = text,
                //   clearOnSubmit: true,
                //   textSubmitted: (text) => setState(() {
                //     if (text != "") {
                //       added.add(text);
                //     }
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> suggestions = [
  "Apple",
  "Armidillo",
  "Actual",
  "Actuary",
  "America",
  "Argentina",
  "Australia",
  "Antarctica",
  "Blueberry",
  "Cheese",
  "Danish",
  "Eclair",
  "Fudge",
  "Granola",
  "Hazelnut",
  "Ice Cream",
  "Jely",
  "Kiwi Fruit",
  "Lamb",
  "Macadamia",
  "Nachos",
  "Oatmeal",
  "Palm Oil",
  "Quail",
  "Rabbit",
  "Robert",
  "Salad",
  "T-Bone Steak",
  "Urid Dal",
  "Vanilla",
  "Waffles",
  "Yam",
  "Zest"
];
