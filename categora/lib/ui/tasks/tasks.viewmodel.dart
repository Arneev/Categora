import 'dart:developer';

import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/log.dart';
import 'package:categora/services/Firestore.dart';
import 'package:categora/services/Router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class TasksViewModel extends BaseViewModel {
  static List<Item> items = [];

  String filterChosen = 'Due Date';
  List<String> itemFilterOptions = ["Due Date", "Priority"];

  void setFilterChoice(String newOption) {
    filterChosen = newOption;
  }

  void sortItems() {
    if (filterChosen == "Due Date") {
      items = Item.sortByDueDate(items);
      notifyListeners();
    } else if (filterChosen == "Priority") {
      items = Item.sortByPriority(items);
      notifyListeners();
    } else {
      log.w("Failed to choose to sortItems");
    }
  }

  Future<void> getAllItems() async {
    setBusy(true);
    items = await FirestoreService.getAllItems();
    sortItems();
    setBusy(false);
  }

  Future<void> goToItems(
      {required Item item, required BuildContext context}) async {
    final Category category = await FirestoreService.getCategoryById(
        categoryID: item.categoryDocumentID);

    Navigator.pop(context);
    router.goToItems(context, category);
  }
}
