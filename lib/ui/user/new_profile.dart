import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileThreePage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile3.dart";
  final image = "assets/images/campsites/campsite_1.jpg";

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    final Color screenCardsColor = Theme.of(context).appBarTheme.color;
    final TextStyle cardTextColor =
        TextStyle(color: Theme.of(context).textTheme.bodyText1.color);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: firestoreDatabase.userDetailsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data.first;
                  return Visibility(
                    visible: user != null ? true : false,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: user.photoUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16.0),
                                    margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        color: screenCardsColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 96.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                user.displayName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                              SizedBox(height: 30.0),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("285"),
                                                  Text("Likes")
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("3025"),
                                                  Text("Comments")
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("650"),
                                                  Text("Favourites")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: user.photoUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: EdgeInsets.only(left: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: screenCardsColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("User information"),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text("Email"),
                                      subtitle: Text(
                                        user.email,
                                        style: cardTextColor,
                                      ),
                                      leading: Icon(Icons.email),
                                    ),
                                    ListTile(
                                      title: Text("Phone"),
                                      subtitle: Text(
                                        user.phoneNumber,
                                        style: cardTextColor,
                                      ),
                                      leading: Icon(Icons.phone),
                                    ),
                                    ListTile(
                                      title:
                                          Text("About", style: cardTextColor),
                                      subtitle: Text(
                                        "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab.",
                                        style: cardTextColor,
                                      ),
                                      leading: Icon(Icons.person),
                                    ),
                                    ListTile(
                                      title: Text("Joined Date"),
                                      subtitle: Text("15 February 2019"),
                                      leading: Icon(Icons.calendar_view_day),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
