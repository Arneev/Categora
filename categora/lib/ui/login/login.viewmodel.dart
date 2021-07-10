import 'package:categora/helpers/toast.dart';
import 'package:categora/helpers/validation.helper.dart';
import 'package:categora/services/Database.dart';
import 'package:categora/services/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  Future<void> onLogin(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (!isValidCredientials(email, password)) {
      toast("Enter Valid Details");
      return;
    }

    //Attempt to create account, will throw an error if there is a problem
    bool isSuccessful = await Database.login(email: email, password: password);

    //If registration was successful, go to the login page
    if (isSuccessful) {
      goToCategories(context);
    }
  }

  void goForgotPasswordPage(BuildContext context) {
    goToForgotPassword(context);
  }

  void goRegister(BuildContext context) {
    goToRegister(context);
  }
}
