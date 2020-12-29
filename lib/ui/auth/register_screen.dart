import 'package:shopping_list/services/firestore_path.dart';
import 'package:shopping_list/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/app_localizations.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/providers/auth_provider.dart';
import 'package:shopping_list/routes.dart';
import 'package:provider/provider.dart';

UserModel userModel;
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirestoreService service = FirestoreService.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          // _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: _buildForm(context),
          ),
        ],
      ),
    );
  }

  Future submitInfo(userModel) async {
    service.setData(
        path: FirestoreUserPath.addUserInfo(
            userModel["id"], documentIdFromCurrentDate()),
        data: userModel);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/images/camping.png')),
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2.color),
                  validator: (value) => value.isEmpty
                      ? AppLocalizations.of(context)
                          .translate("loginTxtErrorEmail")
                      : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelText: AppLocalizations.of(context)
                          .translate("loginTxtEmail"),
                      labelStyle:
                          TextStyle(color: Theme.of(context).appBarTheme.color),
                      border: OutlineInputBorder()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 12,
                    controller: _passwordController,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2.color),
                    validator: (value) => value.length < 6
                        ? AppLocalizations.of(context)
                            .translate("loginTxtErrorPassword")
                        : null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        labelText: AppLocalizations.of(context)
                            .translate("loginTxtPassword"),
                        labelStyle: TextStyle(
                            color: Theme.of(context).appBarTheme.color),
                        border: OutlineInputBorder()),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2.color),
                  validator: (value) =>
                      value.isEmpty ? "Please enter a name" : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.verified_user,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelText: "Name",
                      labelStyle:
                          TextStyle(color: Theme.of(context).appBarTheme.color),
                      border: OutlineInputBorder()),
                ),
                authProvider.status == Status.Registering
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("loginBtnSignUp"),
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any

                            userModel =
                                await authProvider.registerWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);

                            submitInfo(UserModel(
                                    displayName: "Roma",
                                    email: "dfvdfsvdfdfbdbf",
                                    id: userModel.id,
                                    phoneNumber: "444444444",
                                    photoUrl:
                                        "https://firebasestorage.googleapis.com/v0/b/camping-fanatics.appspot.com/o/images%2Fdefault_image.jpg?alt=media&token=81d14530-ce54-46a0-aa2a-26a3f4855cea",
                                    gender: "Male")
                                .toMap());

                            if (userModel == null) {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .translate("loginTxtErrorSignIn")),
                              ));
                            }
                          }
                        }),
                authProvider.status == Status.Registering
                    ? Center(
                        child: null,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)
                              .translate("loginTxtHaveAccount"),
                          style: Theme.of(context).textTheme.button,
                        )),
                      ),
                authProvider.status == Status.Registering
                    ? Center(
                        child: null,
                      )
                    : FlatButton(
                        child: Text(AppLocalizations.of(context)
                            .translate("loginBtnLinkSignIn")),
                        textColor: Theme.of(context).iconTheme.color,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.login);
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
