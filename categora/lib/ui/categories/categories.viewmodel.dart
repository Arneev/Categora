import 'dart:developer';

import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/log.dart';
import 'package:categora/services/Database.dart';
import 'package:categora/services/Firestore.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:categora/classes/category.class.dart';
import 'package:categora/helpers/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import '../widgets/alertDialog.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoriesViewModel extends BaseViewModel {
  //Variables
  static List<Category> categories = [];

  static List<String> categoryFilterOptions = [
    "Last Accessed",
    "Alphabetically",
    "Most Accessed"
  ];

  static String filterChosen = categoryFilterOptions[0];

  void setFilterChosen({required String newOption}) {
    filterChosen = newOption;
  }

  void sortAll() {
    if (filterChosen == "Last Accessed") {
      categories = Category.sortByLastAccessed(categories);
      notifyListeners();
    } else if (filterChosen == "Alphabetically") {
      categories = Category.sortAlphabetically(categories);
      notifyListeners();
    } else if (filterChosen == "Most Accessed") {
      categories = Category.sortByNumbAccessed(categories);
      notifyListeners();
    } else {
      log.w("Invalid Filter Options, $filterChosen");
    }
  }

  //Listen to Category Updates in Firestore
  void listenToCategories() {
    setBusy(true);

    FirestoreService.listenToCategoriesRealTime().listen((categoriesData) {
      categories = categoriesData;
      sortAll();
      notifyListeners();

      setBusy(false);
    });
  }

  Category getCategoryByID(String documentID) {
    return categories
        .firstWhere((category) => category.documentID == documentID);
  }

  void updateCategory(BuildContext context, Category category) {
    TextEditingController categoryController =
        TextEditingController(text: category.name);

    AlertDialog alertDialog = myAlertDialog(
      title: "Change Category",
      fontScale: 1.0,
      extraWidget: MyButton(
        padding: 10.0,
        fontSize: fontSizeMedium * 0.8,
        text: "Delete",
        onTap: () => _deleteCategory(context: context, category: category),
        backgroundColor: Colors.black38,
        fontColor: brightRed,
      ),
      content: [
        MyTextField(controller: categoryController, hintText: "Category Name"),
      ],
      buttons: [
        MyAlertButton(
          text: "Change",
          onTap: () => _updateCategory(
            categoryName: categoryController.text.trim(),
            category: category,
            context: context,
          ),
        ),
        MyAlertButton(text: "Cancel", onTap: () => Navigator.pop(context)),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  //Add Category
  Future<void> addCategory(BuildContext context) async {
    final TextEditingController categoryController =
        TextEditingController(text: "");

    AlertDialog alertDialog = myAlertDialog(
      title: "Create Category",
      content: [
        Container(
          child: MyTextField(
            fontSize: fontSizeSmall,
            padding: 5,
            controller: categoryController,
            hintText: "Category Name",
          ),
        )
      ],
      buttons: [
        MyAlertButton(
          text: "Add",
          onTap: () {
            _addCategory(
              context: context,
              categoryName: categoryController.text.trim(),
            );
          },
        ),
        MyAlertButton(
          onTap: () {
            Navigator.pop(context);
          },
          text: "Cancel",
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _addCategory(
      {required String categoryName, required BuildContext context}) async {
    if (categoryName.length == 0) {
      toast("Cannot add empty category");
      return;
    }

    FirestoreService.addCategory(categoryName).then((_) {
      sortAll();
      notifyListeners();
    });

    Navigator.pop(context);
  }

  void _deleteCategory(
      {required BuildContext context, required Category category}) {
    if (categories.length == 1) {
      if (categories[0].documentID == category.documentID) {
        categories.clear();
      }
    }

    FirestoreService.deleteCategory(categoryDocId: category.documentID)
        .then((_) {
      sortAll();
      notifyListeners();
    });

    Navigator.pop(context);
  }

  void _updateCategory(
      {required String categoryName,
      required Category category,
      required BuildContext context}) {
    FirestoreService.updateCategory(
            newCategoryName: categoryName, category: category)
        .then((_) {
      sortAll();
      notifyListeners();
    });

    Navigator.pop(context);
  }
}
