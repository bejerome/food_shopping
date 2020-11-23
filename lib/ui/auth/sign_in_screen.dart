import 'package:flutter/material.dart';
import 'package:camping_fanatics/app_localizations.dart';
import 'package:camping_fanatics/flavor.dart';
import 'package:camping_fanatics/providers/auth_provider.dart';
import 'package:camping_fanatics/routes.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
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
            child: Container(
              child: _buildForm(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        // Create a Stack Widget
        body: Stack(
          children: <Widget>[
            // Add a SizedBox to contain our video.
            Center(
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width.toDouble(),
                height: MediaQuery.of(context).size.height.toDouble(),
                child: Image.asset(
                  'assets/images/camping.png',
                ),
              ),
            ),
            SizedBox.expand(
                child: FittedBox(
              child: SizedBox(),
              // If your background video doesn't look right, try changing the BoxFit property.
              // BoxFit.fill created the look I was going for.
              fit: BoxFit.cover,
            )),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 220, right: 24, left: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: (value) => value.isEmpty
                            ? AppLocalizations.of(context)
                                .translate("loginTxtErrorEmail")
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).appBarTheme.color,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate("loginTxtEmail"),
                          fillColor: Color.fromRGBO(0, 0, 0, .6),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        child: TextFormField(
                          obscureText: true,
                          maxLength: 12,
                          controller: _passwordController,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: (value) => value.length < 6
                              ? AppLocalizations.of(context)
                                  .translate("loginTxtErrorPassword")
                              : null,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(0, 0, 0, .6),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).appBarTheme.color,
                              ),
                              labelText: AppLocalizations.of(context)
                                  .translate("loginTxtPassword"),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.7),
                              )),
                        ),
                      ),
                      authProvider.status == Status.Authenticating
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : RaisedButton(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("loginBtnSignIn"),
                                style: Theme.of(context).textTheme.button,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context)
                                      .unfocus(); //to hide the keyboard - if any

                                  bool status = await authProvider
                                      .signInWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text);

                                  if (!status) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(AppLocalizations.of(context)
                                          .translate("loginTxtErrorSignIn")),
                                    ));
                                  }
                                }
                              }),
                      authProvider.status == Status.Authenticating
                          ? Center(
                              child: null,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 48),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context)
                                    .translate("loginTxtDontHaveAccount"),
                                style: Theme.of(context).textTheme.button,
                              )),
                            ),
                      authProvider.status == Status.Authenticating
                          ? Center(
                              child: null,
                            )
                          : FlatButton(
                              child: Text(AppLocalizations.of(context)
                                  .translate("loginBtnLinkCreateAccount")),
                              textColor: Theme.of(context).appBarTheme.color,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.register);
                              },
                            ),
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            Provider.of<Flavor>(context).toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
