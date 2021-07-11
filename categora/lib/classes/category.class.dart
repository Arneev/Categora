import 'dart:async';

import 'package:categora/classes/item.class.dart';
import 'package:categora/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  Timestamp lastAccessed;
  int numbAccessed;
  String documentID;

  Category({
    required this.name,
    required this.lastAccessed,
    required this.documentID,
    this.numbAccessed = 1,
  });

  static Category fromMap(Map<String, dynamic> map, String docID) {
    return new Category(
      name: map['name'],
      lastAccessed: map['lastAccessed'],
      numbAccessed: map['numbAccessed'],
      documentID: docID,
    );
  }

  Map<String, Object?> toMap() {
    return <String, dynamic>{
      "name": name,
      "numbAccessed": numbAccessed,
      "lastAccessed": lastAccessed,
      "userID": Database.user!.uid,
    };
  }

  static List<Category> sortByNumbAccessed(List<Category> categories) {
    //Sort by descending order
    categories.sort((a, b) => a.numbAccessed.compareTo(b.numbAccessed));

    return categories.reversed.toList();
  }

  static List<Category> sortByLastAccessed(List<Category> categories) {
    //Sort by descending order
    categories.sort((a, b) => a.lastAccessed.compareTo(b.lastAccessed));

    return categories.reversed.toList();
  }

  static List<Category> sortAlphabetically(List<Category> categories) {
    //Sort by descending order
    return categories..sort((a, b) => a.name.compareTo(b.name));
  }
}
