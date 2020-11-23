import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:camping_fanatics/ui/home/shopping_list_view.dart';
import 'package:camping_fanatics/ui/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final Function menuCallBack;
  Dashboard({this.menuCallBack});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Color.fromRGBO(16, 37, 60, 1),
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: Color.fromRGBO(48, 147, 152, 1),
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel user;
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 235, 1),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          StreamBuilder(
              stream: firestoreDatabase.userDetailsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  user = snapshot.data.first;
                  return Visibility(
                      visible: user != null ? true : false,
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 50,
                          child: Column(
                            children: [
                              TopBar(
                                title: "Dashboard",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    CircularPercentIndicator(
                                      radius: 50.0,
                                      lineWidth: 5.0,
                                      animation: true,
                                      percent: 0.55,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.red,
                                      backgroundColor:
                                          Color.fromRGBO(249, 190, 124, 1),
                                      center: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 35.0,
                                        backgroundImage:
                                            NetworkImage(user.photoUrl),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: null,
                                onTitleTapped: null,
                              ),
                              Expanded(
                                child: FruitAppCartView(tabController),
                              ),
                            ],
                          ),
                        ),
                      ]));
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              }),
        ],
      ),
    );
  }
}
