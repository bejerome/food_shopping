import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/routes.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camping_fanatics/ui/widgets/active_project_card.dart';
import 'package:camping_fanatics/ui/widgets/task_column.dart';
import 'package:camping_fanatics/ui/home/banner.dart';

class Dashboard extends StatefulWidget {
  final Function menuCallBack;
  Dashboard({this.menuCallBack});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                              TopBanner(
                                user: user,
                                width: width,
                                menuCallBack: widget.menuCallBack,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                subheading('My Tasks'),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        Routes.calendar);
                                                  },
                                                  child: calendarIcon(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15.0),
                                            TaskColumn(
                                              icon: Icons.alarm,
                                              iconBackgroundColor: Colors.red,
                                              title: 'To Do',
                                              subtitle:
                                                  '5 tasks now. 1 started',
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            TaskColumn(
                                              icon: Icons.blur_circular,
                                              iconBackgroundColor:
                                                  Colors.yellow,
                                              title: 'In Progress',
                                              subtitle:
                                                  '1 tasks now. 1 started',
                                            ),
                                            SizedBox(height: 15.0),
                                            TaskColumn(
                                              icon: Icons.check_circle_outline,
                                              iconBackgroundColor: Colors.blue,
                                              title: 'Done',
                                              subtitle:
                                                  '18 tasks now. 13 started',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            subheading('Active Projects'),
                                            SizedBox(height: 5.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ActiveProjectsCard(
                                                  cardColor: Color.fromRGBO(
                                                      48, 147, 152, 1),
                                                  loadingPercent: 0.25,
                                                  title: 'Medical App',
                                                  subtitle: '9 hours progress',
                                                ),
                                                SizedBox(width: 20.0),
                                                ActiveProjectsCard(
                                                  cardColor: Color.fromRGBO(
                                                      228, 100, 113, 1),
                                                  loadingPercent: 0.6,
                                                  title: 'Making History Notes',
                                                  subtitle: '20 hours progress',
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                ActiveProjectsCard(
                                                  cardColor: Color.fromRGBO(
                                                      249, 190, 124, 1),
                                                  loadingPercent: 0.45,
                                                  title: 'Sports App',
                                                  subtitle: '5 hours progress',
                                                ),
                                                SizedBox(width: 20.0),
                                                ActiveProjectsCard(
                                                  cardColor: Color.fromRGBO(
                                                      101, 135, 228, 1),
                                                  loadingPercent: 0.9,
                                                  title:
                                                      'Online Flutter Course',
                                                  subtitle: '23 hours progress',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
