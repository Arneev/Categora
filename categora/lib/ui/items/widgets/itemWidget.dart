import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/helper.dart';
import 'package:categora/ui/items/items.modelview.dart' as modelView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style.dart';

class ItemWidget extends StatelessWidget {
  late final modelView.ItemsViewModel model;
  late final String itemDocumentID;

  ItemWidget({required this.model, required this.itemDocumentID});

  @override
  Widget build(BuildContext context) {
    Item item = model.getItemByID(itemDocumentID);

    final size = MediaQuery.of(context).size;
    String dueTime = getDaysHours(item.dueDate.microsecondsSinceEpoch).trim();
    return GestureDetector(
      //OnHold Give PopUp Box options
      onTap: () => model.changeStatus(item),
      onLongPress: () => model.changeItem(context: context, item: item),
      child: Container(
        width: size.width * 0.8,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: item.getItemColor(),
          // border: Border.all(
          //   color: brightRed,
          // ),
          borderRadius: borderRadius,
          // border: Border.all(width: 1.0, color: brightRed.withAlpha(128)),
        ),
        child: (dueTime.length == 0)
            ? Container(
                padding: EdgeInsets.all(1),
                child: SelectableText(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeMedium,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontMont,
                    decoration: (item.status == ItemStatus.Done)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    child: SelectableText(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSizeMedium,
                        fontWeight: FontWeight.w500,
                        fontFamily: fontMont,
                        decoration: (item.status == ItemStatus.Done)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: SelectableText(
                      dueTime,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: fontMont,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizeSmall,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
