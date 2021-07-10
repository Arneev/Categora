import 'dart:async';

import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/log.dart';
import 'package:categora/helpers/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';

import 'Database.dart';

class FirestoreService {
  //Singleton
  FirestoreService._privateConstructor();
  static final FirestoreService instance =
      FirestoreService._privateConstructor();

  //Collection References
  static CollectionReference categoriesCollectionReference =
      Database.firestore.collection("categories");

  //Stream Controller
  static final StreamController<List<Category>> _categoryController =
      StreamController<List<Category>>.broadcast();

  ///======================[Functions]======================///
  ///[Category]
  ///
  //Get all categories user
  static Stream<List<Category>> listenToCategoriesRealTime() {
    categoriesCollectionReference
        .where("userID", isEqualTo: Database.user!.uid)
        .snapshots()
        .listen((categoryDocs) {
      ///Returning it in [List<Category] form
      List<Category> categories = [];

      if (categoryDocs.docs.isNotEmpty) {
        for (var doc in categoryDocs.docs) {
          //Adding to categories list
          final map = doc.data() as Map<String, dynamic>;
          final String docID = doc.id;

          Category category = Category.fromMap(map, docID);

          categories.add(category);
        }
        _categoryController.add(categories);
      }
    });

    return _categoryController.stream;
  }

  //Add Category
  static void addCategory(String categoryName) {
    Map<String, dynamic> map = {
      "name": categoryName,
      "lastAccessed": DateTime.now(),
      "numbAccessed": 1,
      "userID": Database.user!.uid,
    };

    categoriesCollectionReference.add(map);
  }

  ///[Items]
  Stream<List<Item>> listenToItemsByCategoryRealTime(
      {required String categoryDocumentID,
      required StreamController<List<Item>> itemController}) {
    //Setting up StreamController for items for Category
    categoriesCollectionReference
        .doc(categoryDocumentID)
        .collection("items")
        .snapshots()
        .listen((itemDocs) {
      // toast(itemDocs.docs[0].data().toString());
      List<Item> items = [];

      if (itemDocs.docs.isNotEmpty) {
        for (var itemDoc in itemDocs.docs) {
          // ignore: unnecessary_cast
          final itemMap = itemDoc.data() as Map<String, dynamic>;
          final String itemDocID = itemDoc.id;
          items.add(Item.fromMap(
            map: itemMap,
            documentID: itemDocID,
            categoryDocumentId: categoryDocumentID,
          ));
        }
        // toast(items[0]);
        itemController.add(items);
      }
    });

    return itemController.stream;
  }

  void changeStatusItem({required Item item}) {
    item.status = (item.status == ItemStatus.Done)
        ? ItemStatus.InProgress
        : ItemStatus.Done;

    try {
      categoriesCollectionReference
          .doc(item.categoryDocumentID)
          .collection("items")
          .doc(item.documentID)
          .update(item.toMap());
    } on PlatformException catch (e) {
      toast(e.message);
    } catch (e) {
      toast(e.toString());
    }
  }

  static void addItemToCategory({
    required String name,
    required DateTime dueDate,
    required ItemStatus status,
    required ItemColor color,
    required String categoryDocId,
  }) {
    final Map<String, dynamic> map = <String, dynamic>{
      "color": EnumToString.convertToString(color),
      "status": EnumToString.convertToString(status),
      "name": name,
      "dueDate": dueDate,
    };

    categoriesCollectionReference
        .doc(categoryDocId)
        .collection("items")
        .add(map);
  }

  static void changeItemFromCategory({
    required String name,
    required DateTime dueDate,
    required ItemStatus status,
    required ItemColor color,
    required String categoryDocId,
    required String itemDocId,
  }) {
    final Map<String, dynamic> map = <String, dynamic>{
      "color": EnumToString.convertToString(color),
      "status": EnumToString.convertToString(status),
      "name": name,
      "dueDate": dueDate,
    };

    try {
      categoriesCollectionReference
          .doc(categoryDocId)
          .collection("items")
          .doc(itemDocId)
          .update(map);
    } on PlatformException catch (e) {
      toast(e.message);
    } catch (e) {
      toast(e.toString());
    }
  }

  static void deleteItem(Item item) {
    categoriesCollectionReference
        .doc(item.categoryDocumentID)
        .collection("items")
        .doc(item.documentID)
        .delete();
  }
}
