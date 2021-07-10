import 'package:categora/ui/forgot_password/forgotPassword.viewmodel.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:categora/ui/widgets/text_tap.dart';
import 'package:categora/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (BuildContext context, ForgotPasswordViewModel model, _) {
          return MyScaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Heading("Forgot Password"),
                MyTextField(
                    controller: model.emailController, hintText: "e-mail"),
                MyButton(
                  text: "Submit",
                  onTap: () async => await model.onForgotPassword(context),
                ),
                TextTap(
                  text: "Login",
                  onTap: () => model.goToLoginPage(context),
                )
              ],
            ),
          );
        });
  }
}
