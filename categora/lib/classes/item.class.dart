import 'package:categora/helpers/enums.dart';
import 'package:categora/style.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class Item {
  String name;
  DateTime dueDate;
  ItemStatus status;
  ItemColor color;
  String documentID;
  String categoryDocumentID;

  Item({
    required this.name,
    required this.dueDate,
    required this.status,
    required this.color,
    required this.documentID,
    required this.categoryDocumentID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "dueDate": dueDate,
      "status": EnumToString.convertToString(status),
      "color": EnumToString.convertToString(color)
    };
  }

  Color getItemColor() {
    return getColorByItemColor(color);
  }

  static Color getColorByItemColor(ItemColor itemColor) {
    switch (itemColor) {
      case ItemColor.Green:
        return itemColGreen;

      case ItemColor.White:
        return itemColWhite;

      case ItemColor.Yellow:
        return itemColYellow;

      default:
        return darkNavyBlue;
    }
  }

  String toString() {
    return "name: $name, status: ${EnumToString.convertToString(status)}, color: ${EnumToString.convertToString(color)}, dueDate: ${dueDate.toString()}, documentID: $documentID";
  }

  static Item fromMap(
      {required Map<String, dynamic> map,
      required String documentID,
      required String categoryDocumentId}) {
    return new Item(
      name: map['name'],
      status: EnumToString.fromString(ItemStatus.values, map['status'])!,
      color: EnumToString.fromString(ItemColor.values, map['color'])!,
      dueDate: DateTime.fromMicrosecondsSinceEpoch(
          map['dueDate'].microsecondsSinceEpoch * 1000),
      documentID: documentID,
      categoryDocumentID: categoryDocumentId,
    );
  }

  static String getPriority(ItemColor itemColor) {
    switch (itemColor) {
      case ItemColor.Green:
        return "Low";
      case ItemColor.White:
        return "Medium";
      case ItemColor.Yellow:
        return "High";
      default:
        return "Medium";
    }
  }
}
