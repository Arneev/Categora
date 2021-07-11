import 'package:categora/style.dart';
import 'package:categora/ui/settings/settings.viewmodel.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/navBar.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.nonReactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (
        BuildContext context,
        SettingsViewModel model,
        _,
      ) {
        final size = MediaQuery.of(context).size;
        return MyScaffold(
          navBar: MyNavBar(),
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Heading("Settings"),
                MyButton(
                    text: "Reset Password",
                    onTap: () => model.resetPassword(context: context)),
                MyButton(
                    text: "Log Out",
                    onTap: () => model.logOut(context: context)),
                MyButton(
                  text: "Delete Account",
                  onTap: () => model.deleteAccount(context: context),
                  backgroundColor: Colors.black54,
                  fontColor: brightRed,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
