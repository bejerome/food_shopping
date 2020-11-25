import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:camping_fanatics/ui/home/shopping_list_view.dart';
import 'package:camping_fanatics/ui/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:adv_fab/adv_fab.dart';

class Dashboard extends StatefulWidget {
  final Function menuCallBack;
  Dashboard({this.menuCallBack});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  AdvFabController mabialaFABController;
  bool useFloatingSpaceBar = false;
  bool useAsFloatingActionButton = true;
  bool useNavigationBar = false;
  TextEditingController itemName;
  @override
  void initState() {
    super.initState();
    mabialaFABController = AdvFabController();
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

  Widget itemForm(BuildContext context) {
    return Form(
      child: Column(
        children: [],
      ),
    );
  }

  void adForm() {
    mabialaFABController.setExpandedWidgetConfiguration(
      expendedContainerMainAxisAlignment: MainAxisAlignment.center,
      showLogs: true,
      heightToExpandTo: 60,
      expendedBackgroundColor: Colors.transparent,
      withChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          width: (MediaQuery.of(context).size.width),

          ///[IMPORTANT]: the height percentage shall be less than [heightToExpandTo]
          ///in the next line we use 20%
          height: (MediaQuery.of(context).size.height / 100) * 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8),
                  child: GestureDetector(
                      onTap: () => mabialaFABController.collapseFAB(),
                      child: Text('Add Item')),
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: (MediaQuery.of(context).size.width),
                        height: (MediaQuery.of(context).size.height / 100) * 9,
                        color: Colors.pink,
                        child: null,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel user;
    adForm();
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: AdvFab(
          floatingActionButtonExpendedWidth: 90,
          floatingActionButtonIconColor: Colors.orangeAccent,
          onFloatingActionButtonTapped: () {
            mabialaFABController.isCollapsed
                ? mabialaFABController.expandFAB()
                : mabialaFABController.collapseFAB();
          },
          floatingActionButtonIcon: Icons.add_circle,
          floatingSpaceBarContainerWidth: 90,
          controller: mabialaFABController),
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
                    child: Column(
                      children: [
                        Container(
                          height: height - 50,
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
                        )
                      ],
                    ),
                  );

                  // This trailing comma makes auto-formatting nicer for build methods.

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
