import 'package:categora/helpers/toast.dart';
import 'package:categora/helpers/validation.helper.dart';
import 'package:categora/services/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../services/Database.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController emailController = new TextEditingController(text: "");

  Future<void> onForgotPassword(BuildContext context) async {
    String email = emailController.text.trim();

    if (!validEmail(email)) {
      toast("Please enter valid email address");
      return;
    }

    bool isSuccessful = await Database.forgotPassword(email: email);

    if (isSuccessful) {
      toast("Please check your email");
      goToLoginPage(context);
    }
  }

  goToLoginPage(BuildContext context) {
    goToLogin(context);
  }
}
