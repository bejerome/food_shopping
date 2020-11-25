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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: ChipsChoice<int>.single(
                    choiceActiveStyle: C2ChoiceStyle(
                        borderColor: Colors.green,
                        color: Colors.green,
                        labelStyle: TextStyle(color: Colors.green)),
                    choiceStyle: C2ChoiceStyle(
                        color: Colors.orange,
                        borderColor: Colors.orange,
                        labelStyle: TextStyle(color: Colors.orange)),
                    value: tag,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  width: (MediaQuery.of(context).size.width / 2),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                RaisedButton(
                  onPressed: () {},
                )
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
