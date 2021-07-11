import 'package:categora/helpers/toast.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/registration/registration.viewmodel.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:categora/ui/widgets/spacing.dart';
import 'package:categora/ui/widgets/text_tap.dart';
import 'package:categora/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.nonReactive(
      viewModelBuilder: () => RegistrationViewModel(),
      builder: (
        BuildContext context,
        RegistrationViewModel model,
        _,
      ) {
        final size = MediaQuery.of(context).size;
        return MyScaffold(
          isScrollView: false,
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Heading("Registration"),
                //Input Box for email
                MyTextField(
                  controller: model.emailController,
                  hintText: "e-mail",
                ),

                //Input Box for password
                MyTextField(
                  controller: model.passwordController,
                  hintText: "Password",
                  obsecureFlag: true,
                ),
                //Registration Button
                MyButton(
                    text: "Register",
                    onTap: () async {
                      await model.onRegister(context);
                    }),

                //Login
                TextTap(
                  text: "Login",
                  onTap: () => model.goToLoginPage(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
