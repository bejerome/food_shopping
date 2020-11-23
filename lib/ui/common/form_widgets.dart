import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String validatorText;
  final IconData icon;
  final String label;
  final bool isPassword;
  final Key key;

  CustomTextfield({
    this.controller,
    this.validatorText,
    this.icon,
    this.label,
    this.key,
    this.isPassword = false,
  });
  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: TextFormField(
        key: widget.key,
        obscureText: widget.isPassword,
        controller: widget.controller,
        style: TextStyle(color: Theme.of(context).appBarTheme.color),
        validator: (value) => value.isEmpty ? widget.validatorText : null,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Theme.of(context).appBarTheme.color),
          filled: false,
          prefixIcon: Icon(
            widget.icon,
            color: Theme.of(context).appBarTheme.color,
          ),
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).appBarTheme.color,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.color,
            ),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
      ),
    );
  }
}

class CustomNoteTextField extends StatefulWidget {
  final TextEditingController noteController;
  final int maxLine;
  final String label;

  CustomNoteTextField({Key key, this.maxLine, this.noteController, this.label})
      : super(key: key);

  @override
  _CustomNoteTextFieldState createState() => _CustomNoteTextFieldState();
}

class _CustomNoteTextFieldState extends State<CustomNoteTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.noteController,
        style: Theme.of(context).textTheme.bodyText1,
        maxLines: widget.maxLine,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).appBarTheme.color,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.color,
            ),
            borderRadius: BorderRadius.circular(25.7),
          ),
          labelText: "Notes",
          labelStyle: TextStyle(color: Theme.of(context).appBarTheme.color),
          alignLabelWithHint: true,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
        validator: (value) =>
            value.isEmpty ? widget.label + " can't be empty" : null,
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  final bool checkBoxStatus;
  final String label;
  CustomCheckBox({Key key, this.checkBoxStatus, this.label}) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.label,
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline3.color),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                })
          ],
        ),
      ),
    );
  }
}

class CustomeCheckBoxes extends StatefulWidget {
  CustomeCheckBoxes({Key key})
      : super(
          key: key,
        );

  @override
  _CustomeCheckBoxesState createState() => _CustomeCheckBoxesState();
}

class _CustomeCheckBoxesState extends State<CustomeCheckBoxes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Text(
              'Site Options',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: null
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
