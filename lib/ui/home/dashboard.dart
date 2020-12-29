import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/providers/site_provider.dart';
import 'package:shopping_list/services/firestore_database.dart';
import 'package:shopping_list/ui/home/shopping_list_view.dart';
import 'package:shopping_list/ui/widgets/custom_top_bar.dart';
import 'package:shopping_list/ui/widgets/shopping_form.dart';
import 'package:shopping_list/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:adv_fab/adv_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      expendedContainerMainAxisAlignment: MainAxisAlignment.end,
      expendedContainerCrossAxisAlignment: CrossAxisAlignment.center,
      showLogs: true,
      heightToExpandTo: 55,
      expendedBackgroundColor: Colors.green,
      withChild: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,

            ///[IMPORTANT]: the height percentage shall be less than [heightToExpandTo]
            ///in the next line we use 20%
            height: (MediaQuery.of(context).size.height / 100) * 50,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => mabialaFABController.collapseFAB(),
                      child: FaIcon(
                        FontAwesomeIcons.windowClose,
                        size: 40,
                      ),
                    )),
                ShoppingForm(formController: mabialaFABController),
              ],
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
      backgroundColor: Color.fromRGBO(255, 249, 235, 1),
      floatingActionButton: AdvFab(
          collapsedColor: Colors.green,
          useElevation: true,
          useAsFloatingActionButton: true,
          floatingActionButtonExpendedWidth: 92,
          floatingActionButtonIconColor: Colors.white,
          onFloatingActionButtonTapped: () {
            mabialaFABController.isCollapsed
                ? mabialaFABController.expandFAB()
                : mabialaFABController.collapseFAB();
          },
          floatingActionButtonIcon: FontAwesomeIcons.cartPlus,
          controller: mabialaFABController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                            height: height,
                            child: Column(
                              children: [
                                TopBar(
                                  title: "Shopping List",
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TabBar(
                                    controller: tabController,
                                    indicatorColor: Colors.lightGreen,
                                    labelColor: Colors.black,
                                    unselectedLabelColor:
                                        Colors.grey.withOpacity(0.6),
                                    isScrollable: true,
                                    tabs: <Widget>[
                                      Tab(
                                        child: GestureDetector(
                                            onTap: () {},
                                            child: TabText.tabText1),
                                      ),
                                      Tab(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                Provider.of<SiteProvider>(
                                                        context,
                                                        listen: false)
                                                    .createShoppingItems(
                                                        cat: "fruits");
                                              });
                                            },
                                            child: TabText.tabText2),
                                      ),
                                      Tab(
                                        child: TabText.tabText3,
                                      ),
                                      Tab(
                                        child: TabText.tabText4,
                                      ),
                                      Tab(
                                        child: TabText.tabText5,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: FruitAppCartView(tabController)),
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
