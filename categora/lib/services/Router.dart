import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/constants/route_name.dart';
import 'package:categora/services/Firestore.dart';
import 'package:categora/services/Router.helper.dart';
import 'package:categora/ui/categories/categories.view.dart';
import 'package:categora/ui/forgot_password/forgotPassword.view.dart';
import 'package:categora/ui/items/items.view.dart';
import 'package:categora/ui/login/login.view.dart';
import 'package:categora/ui/registration/registration.view.dart';
import 'package:categora/ui/settings/settings.view.dart';
import 'package:categora/ui/tasks/tasks.view.dart';
import 'package:flutter/material.dart';

//Generate Routes
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //Go To Login
    case loginRoute:
      return materialRouteWrap(LoginView(), settings);

    //Go To Registration
    case registrationRoute:
      return materialRouteWrap(RegistrationView(), settings);

    //Go To Categories
    case categoriesRoute:
      return materialRouteWrap(CategoriesView(), settings);

    //Go To Forgot Password
    case forgotPasswordRoute:
      return materialRouteWrap(ForgotPasswordView(), settings);

    //Go To Settings
    case settingsRoute:
      return materialRouteWrap(SettingsView(), settings);

    //Go To Tasks
    case tasksRoute:
      return materialRouteWrap(TasksView(), settings);

    /// Go To Items of [Category]
    case itemsRoute:
      final args = settings.arguments as Category;
      return materialRouteWrap(ItemsView(category: args), settings);

    //Go To Login
    default:
      return materialRouteWrap(LoginView(), settings);
  }
}

//Go To Functions
void goToLogin(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }

  Navigator.pushNamed(context, loginRoute);
}

void goToRegister(BuildContext context) {
  Navigator.pushNamed(context, registrationRoute);
}

void goToCategories(BuildContext context) {
  Navigator.pushNamed(context, categoriesRoute);
}

void goToForgotPassword(BuildContext context) {
  Navigator.pushNamed(context, forgotPasswordRoute);
}

void goToTasks(BuildContext context) {
  Navigator.pushNamed(context, tasksRoute);
}

void goToSettings(BuildContext context) {
  Navigator.pushNamed(context, settingsRoute);
}

void goToItems(BuildContext context, Category category) {
  //Update Category last Accessed and numbAccessed
  FirestoreService.updateCategoryAccess(category: category);
  Navigator.pushNamed(context, itemsRoute, arguments: category);
}
