import 'package:shopping_list/providers/site_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/flavor.dart';
import 'package:shopping_list/my_app.dart';
import 'package:shopping_list/providers/auth_provider.dart';
import 'package:shopping_list/providers/language_provider.dart';
import 'package:shopping_list/providers/theme_provider.dart';
import 'package:shopping_list/services/firestore_database.dart';
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
          Provider<Flavor>.value(value: Flavor.dev),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
          ChangeNotifierProvider<SiteProvider>(
            create: (context) => SiteProvider(),
          ),
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        ),
      ),
    );
  });
}
