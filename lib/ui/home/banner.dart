import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/ui/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TopBanner extends StatelessWidget {
  final double width;
  final UserModel user;
  final Function menuCallBack;
  TopBanner({Key key, this.width, this.user, this.menuCallBack()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: Container(
          child: TopContainer(
            height: 100,
            width: width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            menuCallBack();
                          },
                          child: Icon(Icons.menu,
                              color: Color.fromRGBO(16, 37, 60, 1), size: 30.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            print("Clicked on search");
                          },
                          child: Icon(Icons.search,
                              color: Color.fromRGBO(16, 37, 60, 1), size: 25.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 5.0,
                        animation: true,
                        percent: 0.55,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.red,
                        backgroundColor: Color.fromRGBO(249, 190, 124, 1),
                        center: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 35.0,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                      ),
                      Expanded(
                        child: Column(
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
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
