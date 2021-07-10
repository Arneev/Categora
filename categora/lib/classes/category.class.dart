import 'dart:async';

import 'package:categora/classes/item.class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  StreamController<List<Item>> items = StreamController<List<Item>>.broadcast();
  DateTime lastAccessed;
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
      lastAccessed: DateTime.fromMicrosecondsSinceEpoch(
          map['lastAccessed'].microsecondsSinceEpoch * 1000),
      numbAccessed: map['numbAccessed'],
      documentID: docID,
    );
  }
}
