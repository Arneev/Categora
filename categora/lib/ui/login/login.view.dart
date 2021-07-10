import 'package:categora/ui/login/login.viewmodel.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:categora/ui/widgets/text_tap.dart';
import 'package:categora/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (
        BuildContext context,
        LoginViewModel model,
        _,
      ) {
        return MyScaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Heading("Login"),
              MyTextField(
                controller: model.emailController,
                hintText: "e-mail",
              ),
              MyTextField(
                controller: model.passwordController,
                hintText: "Password",
                obsecureFlag: true,
              ),
              MyButton(
                text: "Login",
                onTap: () async {
                  await model.onLogin(context);
                },
              ),
              TextTap(
                text: "Forgot Password",
                onTap: () => model.goForgotPasswordPage(context),
              ),
              TextTap(
                text: "Register",
                onTap: () => model.goRegister(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
