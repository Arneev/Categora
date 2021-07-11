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
      } else {
        _categoryController.stream.drain();
      }
    });

    return _categoryController.stream;
  }

  static Future<List<Item>> getAllItems() async {
    final categorySnapshots = (await categoriesCollectionReference
            .where("userID", isEqualTo: Database.user!.uid)
            .get())
        .docs;

    List<Item> items = [];
    for (var categorySnapshot in categorySnapshots) {
      final categoryDocId = categorySnapshot.id;

      final itemSnapshots = await categoriesCollectionReference
          .doc(categoryDocId)
          .collection("items")
          .get();

      if (itemSnapshots.size != 0) {
        for (var itemDoc in itemSnapshots.docs) {
          items.add(
            Item.fromMap(
              map: itemDoc.data(),
              documentID: itemDoc.id,
              categoryDocumentId: categoryDocId,
            ),
          );
        }
      }
    }

    return items;
  }

  //Add Category
  static Future<void> addCategory(String categoryName) async {
    Map<String, dynamic> map = {
      "name": categoryName,
      "lastAccessed": Timestamp.now(),
      "numbAccessed": 1,
      "userID": Database.user!.uid,
    };

    await categoriesCollectionReference.add(map);
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
      } else {
        itemController.stream.drain();
      }
    });

    return itemController.stream;
  }

  Future<void> changeStatusItem({required Item item}) async {
    item.status = (item.status == ItemStatus.Done)
        ? ItemStatus.InProgress
        : ItemStatus.Done;

    try {
      await categoriesCollectionReference
          .doc(item.categoryDocumentID)
          .collection("items")
          .doc(item.documentID)
          .update(item.toMap());
    } on PlatformException catch (e) {
      log.e(e.message);
    } catch (e) {
      log.e(e.toString());
    }
  }

  static Future<void> addItemToCategory({
    required String name,
    required Timestamp dueDate,
    required ItemStatus status,
    required ItemColor color,
    required String categoryDocId,
  }) async {
    final Map<String, dynamic> map = <String, dynamic>{
      "color": EnumToString.convertToString(color),
      "status": EnumToString.convertToString(status),
      "name": name,
      "dueDate": dueDate,
    };

    await categoriesCollectionReference
        .doc(categoryDocId)
        .collection("items")
        .add(map);
  }

  static Future<void> changeItemFromCategory({
    required String name,
    required Timestamp dueDate,
    required ItemStatus status,
    required ItemColor color,
    required String categoryDocId,
    required String itemDocId,
  }) async {
    final Map<String, dynamic> map = <String, dynamic>{
      "color": EnumToString.convertToString(color),
      "status": EnumToString.convertToString(status),
      "name": name,
      "dueDate": dueDate,
    };

    try {
      await categoriesCollectionReference
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

  static Future<void> deleteCategory({required String categoryDocId}) async {
    await categoriesCollectionReference.doc(categoryDocId).delete();
  }

  static Future<void> updateCategory(
      {required String newCategoryName, required Category category}) async {
    category.name = newCategoryName;

    categoriesCollectionReference
        .doc(category.documentID)
        .update(category.toMap());
  }

  static Future<void> updateCategoryAccess({required Category category}) async {
    category.numbAccessed += 1;
    category.lastAccessed = Timestamp.now();

    await categoriesCollectionReference
        .doc(category.documentID)
        .update(category.toMap());
  }

  static Future<void> deleteUserData() async {
    var snapshots = (await categoriesCollectionReference
            .where("userID", isEqualTo: Database.user!.uid)
            .get())
        .docs;

    for (var snapshot in snapshots) {
      var categoryDocId = snapshot.id;

      categoriesCollectionReference.doc(categoryDocId).delete();
    }
  }

  static Future<Category> getCategoryById({required String categoryID}) async {
    final map = (await categoriesCollectionReference.doc(categoryID).get())
        .data() as Map<String, dynamic>;

    return Category.fromMap(map, categoryID);
  }
}
