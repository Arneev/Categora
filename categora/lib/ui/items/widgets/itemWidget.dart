import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/ui/items/items.modelview.dart' as modelView;
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
          border: Border.all(width: 1.0, color: brightRed.withAlpha(128)),
        ),
        child: Text(
          item.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: (item.color == ItemColor.Yellow) ? Colors.white : mustard,
            fontSize: fontSizeMedium,
            fontFamily: fontMont,
            decoration: (item.status == ItemStatus.Done)
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
