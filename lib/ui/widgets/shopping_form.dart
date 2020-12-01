import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';

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
                ListTile(
                  title: TextFormField(
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

                ListTile(
                  title: Container(
                    child: ChipsChoice<int>.single(
                      choiceActiveStyle: C2ChoiceStyle(
                          elevation: 15,
                          borderColor: Colors.transparent,
                          color: Colors.green,
                          labelStyle: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      choiceStyle: C2ChoiceStyle(
                          elevation: 5,
                          color: Colors.orange,
                          borderColor: Colors.transparent,
                          labelStyle: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
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
                      labelText: "QTY",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )),
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
                      onPressed: () {},
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
