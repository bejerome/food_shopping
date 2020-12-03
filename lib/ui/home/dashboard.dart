import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:camping_fanatics/ui/home/shopping_list_view.dart';
import 'package:camping_fanatics/ui/widgets/custom_top_bar.dart';
import 'package:camping_fanatics/ui/widgets/my_text_field.dart';
import 'package:camping_fanatics/ui/widgets/shopping_form.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:adv_fab/adv_fab.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

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

  bool showWhichErrorText = false;
  double width;
  double height;
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

  Widget itemForm(BuildContext context) {
    return Form(
      child: Column(
        children: [],
      ),
    );
  }

  void adForm() {
    mabialaFABController.setExpandedWidgetConfiguration(
      expendedContainerMainAxisAlignment: MainAxisAlignment.start,
      showLogs: true,
      heightToExpandTo: 60,
      expendedBackgroundColor: Colors.lightGreen,
      withChild: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,

              ///[IMPORTANT]: the height percentage shall be less than [heightToExpandTo]
              ///in the next line we use 20%
              height: (MediaQuery.of(context).size.height / 100) * 50,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () => mabialaFABController.collapseFAB(),
                      child: Icon(
                        Icons.close,
                        size: 40,
                      )),
                  ShoppingForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel user;
    adForm();
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButton: AdvFab(
          useAsFloatingActionButton: true,
          floatingActionButtonExpendedWidth: 90,
          floatingActionButtonIconColor: Colors.orangeAccent,
          onFloatingActionButtonTapped: () {
            mabialaFABController.isCollapsed
                ? mabialaFABController.expandFAB()
                : mabialaFABController.collapseFAB();
          },
          floatingActionButtonIcon: Icons.add_circle,
          controller: mabialaFABController),
      backgroundColor: Color.fromRGBO(255, 249, 235, 1),
      body: SingleChildScrollView(
        child: Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
      ),
    );
  }
}
