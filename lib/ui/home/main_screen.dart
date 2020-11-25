import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:camping_fanatics/ui/home/dashboard.dart';
import 'package:camping_fanatics/ui/setting/setting_screen.dart';
import 'package:camping_fanatics/ui/widgets/menu_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:camping_fanatics/ui/widgets/top_container.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  // This widget is the root of your application.
  Color menuText = Color.fromRGBO(249, 190, 124, 1);
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user;
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Column(
          children: [
            menu(context),
          ],
        ),
        AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left: isCollapsed ? 0 : 0.6 * screenWidth,
          right: isCollapsed ? 0 : -0.2 * screenWidth,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Dashboard(
              menuCallBack: toggle,
            ),
          ),
        ),
      ],
    );
  }

  Widget menu(context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(73, 67, 49, 1),
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _menuScaleAnimation,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MenuText(
                      label: "Dashboard",
                      screen: SettingScreen(),
                      toggle: toggle,
                    ),
                    SizedBox(height: 10),
                    MenuText(
                      label: "Settings",
                      screen: SettingScreen(),
                      toggle: toggle,
                    ),
                    SizedBox(height: 10),
                    MenuText(label: "Profile"),
                    SizedBox(height: 10),
                    MenuText(label: "New Tasks"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopBanner extends StatelessWidget {
  final double width;
  final UserModel user;
  final Function menuCallBack;
  TopBanner({Key key, this.width, this.user, this.menuCallBack()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TopContainer(
        height: 200,
        width: width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      menuCallBack();
                    },
                    child: Icon(Icons.menu,
                        color: Color.fromRGBO(16, 37, 60, 1), size: 30.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Clicked on search");
                    },
                    child: Icon(Icons.search,
                        color: Color.fromRGBO(16, 37, 60, 1), size: 25.0),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 90.0,
                      lineWidth: 5.0,
                      animation: true,
                      percent: 0.75,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.red,
                      backgroundColor: Color.fromRGBO(249, 190, 124, 1),
                      center: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 35.0,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            user.displayName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Color.fromRGBO(16, 37, 60, 1),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'App Developer',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(16, 37, 60, 1),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
