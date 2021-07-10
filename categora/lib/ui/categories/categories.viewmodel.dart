import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
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

  //Listen to Category Updates in Firestore
  void listenToCategories() {
    setBusy(true);

    FirestoreService.listenToCategoriesRealTime().listen((categoriesData) {
      categories = categoriesData;
      notifyListeners();

      setBusy(false);
    });
  }

  Category getCategoryByID(String documentID) {
    return categories
        .firstWhere((category) => category.documentID == documentID);
  }

  void updateCategory(BuildContext context, Category category) {
    toast("I update category");
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
            toast("WE add");
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
    toast("tf");
    if (categoryName.length == 0) {
      toast("Cannot add empty category");
      return;
    }

    FirestoreService.addCategory(categoryName);

    Navigator.pop(context);
  }
}
