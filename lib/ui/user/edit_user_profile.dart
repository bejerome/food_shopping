import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/services/firestore_database.dart';
import 'package:shopping_list/ui/common/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/profile.dart';
import 'package:provider/provider.dart';

UserModel user;

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Profile profile;
  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // profile = AppData.profiles[0];
    _nameController = TextEditingController(text: "");
    _addressController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    // Ensure the first frame is shown after the video is initialized.
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 220, right: 24, left: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextfield(
                        controller: _nameController,
                        label: "Name",
                        icon: Icons.access_alarm,
                        validatorText: "Please add a name"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomTextfield(
                          controller: _addressController,
                          label: "Address",
                          icon: Icons.access_alarm,
                          validatorText: "Please add an adress"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomTextfield(
                          controller: _phoneController,
                          label: "email",
                          icon: Icons.access_alarm,
                          validatorText: "Please add a email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomTextfield(
                          controller: _phoneController,
                          label: "photo",
                          icon: Icons.access_alarm,
                          validatorText: "Please add a email"),
                    ),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                print("Validated");
                              }
                            },
                            child: Text(
                              "Submit",
                              style: Theme.of(context).textTheme.bodyText2,
                            )),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     SizedBox(height: 20),
      //     AnimatedSwitcher(
      //         duration: Duration(milliseconds: 750),
      //         transitionBuilder: (Widget child, Animation<double> animation) =>
      //             SlideTransition(
      //               child: child,
      //               position: Tween<Offset>(
      //                       begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
      //                   .animate(animation),
      //             ),
      //         child: StreamBuilder(
      //             stream: firestoreDatabase.userDetailsStream(),
      //             builder: (context, snapshot) {
      //               if (snapshot.hasData) {
      //                 user = snapshot.data.first;
      //                 return Visibility(
      //                     visible: user != null ? true : false,
      //                     child: Container(child: form()));
      //                 // child: HeaderSection(profile: user));
      //               } else {
      //                 return Container(
      //                   width: 0,
      //                   height: 0,
      //                 );
      //               }
      //             })
      //         // HeaderSection(
      //         //   profile: profile,
      //         // ),
      //         ),
      //     SizedBox(height: 40),
      //     Container(child: form())
      //   ],
      // ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final UserModel profile;
  HeaderSection({
    this.profile,
    Key key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image: AssetImage(profile.photoUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Text(
              profile.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              profile.email,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      profile.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('Post')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '33',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('Followers')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '33',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('Following')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
