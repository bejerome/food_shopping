import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camping_fanatics/flavor.dart';
import 'package:camping_fanatics/my_app.dart';
import 'package:camping_fanatics/providers/auth_provider.dart';
import 'package:camping_fanatics/providers/language_provider.dart';
import 'package:camping_fanatics/providers/theme_provider.dart';
import 'package:camping_fanatics/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Flavor>.value(value: Flavor.prod),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        ),
      ),
    );
  });
}
