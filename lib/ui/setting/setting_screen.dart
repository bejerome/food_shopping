import 'package:flutter/material.dart';
import 'package:camping_fanatics/providers/theme_provider.dart';
import 'package:camping_fanatics/ui/setting/setting_language_actions.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Dark theme"),
          subtitle: Text("Turn On the Dark Side"),
          trailing: Switch(
            activeColor: Theme.of(context).appBarTheme.color,
            activeTrackColor: Theme.of(context).textTheme.headline1.color,
            value: Provider.of<ThemeProvider>(context).isDarkModeOn,
            onChanged: (booleanValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(booleanValue);
            },
          ),
        ),
        ListTile(
          title: Text("Language"),
          subtitle: Text("Set Your Prefer Language"),
          trailing: SettingLanguageActions(),
        ),
        ListTile(
          title: Text("Logout"),
          subtitle: Text("Log me out from here"),
          trailing: RaisedButton(
              onPressed: () {
                // _confirmSignOut(context);
              },
              child: Text("Logout")),
        )
      ],
    );
  }
}

//   _confirmSignOut(BuildContext context) {
//     showPlatformDialog(
//         context: context,
//         builder: (_) => PlatformAlertDialog(
//               android: (_) => MaterialAlertDialogData(
//                   backgroundColor: Theme.of(context).appBarTheme.color),
//               title: Text("Alert"),
//               content: Text("This will logout. Are you sure?"),
//               actions: <Widget>[
//                 PlatformDialogAction(
//                   child: PlatformText("Cancel"),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 PlatformDialogAction(
//                   child: PlatformText("Yes"),
//                   onPressed: () {
//                     final authProvider =
//                         Provider.of<AuthProvider>(context, listen: false);

//                     authProvider.signOut();

//                     Navigator.pop(context);
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                         Routes.login, ModalRoute.withName(Routes.login));
//                   },
//                 )
//               ],
//             ));
//   }
// }
