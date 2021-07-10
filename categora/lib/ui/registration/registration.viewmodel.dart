import 'package:categora/helpers/log.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/helpers/validation.helper.dart';
import 'package:categora/services/Database.dart';
import 'package:categora/services/Router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class RegistrationViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  Future<void> onRegister(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (!isValidCredientials(email, password)) {
      toast("Enter Valid Details");
      return;
    }

    //Attempt to create account, will throw an error if there is a problem
    bool isSuccessful =
        await Database.register(email: email, password: password);

    //If registration was successful, go to the login page
    if (isSuccessful) {
      toast("Registration Successful");
      goToLogin(context);
    }

    notifyListeners();
  }

  void goToForgotPassword() {}

  void goToLoginPage(BuildContext context) {
    goToLogin(context);
  }
}
