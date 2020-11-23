import 'package:camping_fanatics/routes.dart';
import 'package:flutter/material.dart';

class MenuText extends StatelessWidget {
  final String label;
  final Widget screen;
  final Function toggle;
  const MenuText({Key key, this.label, this.screen, this.toggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          toggle();
          Navigator.pushNamed(context, Routes.setting);
        },
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
