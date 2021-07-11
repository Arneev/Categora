import 'package:categora/services/Database.dart';
import 'package:categora/services/Firestore.dart';
import 'package:categora/services/Router.dart';
import 'package:categora/ui/widgets/alertDialog.dart';
import 'package:categora/ui/widgets/middleMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  void resetPassword({required BuildContext context}) {
    Database.resetPassword();
    logOut(context: context);
  }

  void logOut({required BuildContext context}) {
    Database.logOut();
    goToLogin(context);
  }

  void deleteAccount({required BuildContext context}) {
    AlertDialog alertDialog = myAlertDialog(title: "Delete Account", content: [
      MiddleMessage(message: "Are you sure you want to delete your account?"),
    ], buttons: [
      MyAlertButton(
        onTap: () {
          Database.deleteAccount();
          Navigator.pop(context);
          logOut(context: context);
        },
        text: "Yes",
      ),
      MyAlertButton(
        onTap: () {
          Navigator.pop(context);
        },
        text: "Cancel",
      )
    ]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
