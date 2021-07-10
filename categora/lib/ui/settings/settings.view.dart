import 'package:categora/ui/settings/settings.viewmodel.dart';
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
        return MyScaffold(
          navBar: MyNavBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Heading("Settings"),
            ],
          ),
        );
      },
    );
  }
}
