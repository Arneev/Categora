import 'dart:async';

import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/services/Firestore.dart';
import 'package:categora/ui/widgets/alertDialog.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/middleMessage.dart';
import 'package:categora/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../../style.dart';

class ItemsViewModel extends BaseViewModel {
  static List<Item> items = [];
  static late Category _category;
  late final StreamController<List<Item>> _itemController;

  void setController(StreamController<List<Item>> itemController) {
    _itemController = itemController;
  }

  void listenToItemsByCategory({required String categoryDocumentID}) {
    setBusy(true);

    FirestoreService.instance
        .listenToItemsByCategoryRealTime(
      categoryDocumentID: categoryDocumentID,
      itemController: _itemController,
    )
        .listen((itemsStream) {
      items = itemsStream;
      notifyListeners();

      setBusy(false);
    });
  }

  Item getItemByID(String itemDocumentID) {
    return items.where((item) => item.documentID == itemDocumentID).first;
  }

  void changeItem({
    required BuildContext context,
    required Item item,
  }) {
    generalPopUp(
      context: context,
      category: _category,
      heading: "Change Item",
      dueDateText: "Change Date",
      confirmButtonText: "Change",
      startIndex: ItemColor.values.indexOf(item.color),
      extraWidget: Column(
        children: [
          // MySpacing(height: 5),
          MyButton(
            padding: 10.0,
            fontSize: fontSizeMedium * 0.8,
            text: "Delete",
            onTap: () => _deleteItem(context: context, item: item),
            backgroundColor: Colors.black38,
            fontColor: brightRed,
          ),
        ],
      ),
      onConfirm: (
          {required TextEditingController itemController,
          required DateTime? dueDate,
          required List<ItemColor> itemColors,
          required int selectedIndex}) {
        final String name = itemController.text.trim();
        if (name.length == 0) {
          Fluttertoast.showToast(msg: "Cannot have empty item");
          return;
        }

        _changeItem(
          name: name,
          dueDate: (dueDate) ?? DateTime(2500),
          status: ItemStatus.InProgress,
          color: itemColors[selectedIndex],
          item: item,
        );
        Navigator.pop(context);
      },
    );
  }

  void changeStatus(Item item) {
    FirestoreService.instance.changeStatusItem(item: item);
    notifyListeners();
  }

  void addItem({required BuildContext context}) {
    generalPopUp(
      context: context,
      category: _category,
      heading: "Add Item",
      dueDateText: "Add Date",
      confirmButtonText: "Add",
      onConfirm: (
          {required TextEditingController itemController,
          required DateTime? dueDate,
          required List<ItemColor> itemColors,
          required int selectedIndex}) {
        final String name = itemController.text.trim();
        if (name.length == 0) {
          Fluttertoast.showToast(msg: "Cannot have empty item");
          return;
        }

        _addItem(
          name: name,
          dueDate: (dueDate) ?? DateTime(2500),
          status: ItemStatus.InProgress,
          color: itemColors[selectedIndex],
        );
        Navigator.pop(context);
      },
    );
  }

  void generalPopUp({
    required BuildContext context,
    required Category category,
    required String heading,
    required String dueDateText,
    required String confirmButtonText,
    required Function onConfirm,
    int startIndex = 1,
    Widget? extraWidget,
  }) {
    final TextEditingController itemController =
        TextEditingController(text: "");
    int selectedIndex = startIndex;
    // ignore: avoid_init_to_null
    DateTime? dueDate = null;

    List<ItemColor> itemColors = ItemColor.values;

    void changeColorIndex(
        {required int newSelectedIndex, required dynamic setState}) {
      if (selectedIndex != newSelectedIndex) {
        setState(() {
          selectedIndex = newSelectedIndex;
        });
      }
    }

    AlertDialog getAlertDialog(
        BuildContext context, void Function(void Function()) setState) {
      return myAlertDialog(
        title: heading,
        extraWidget: extraWidget,
        content: [
          MyTextField(
            fontSize: fontSizeSmall,
            padding: 5,
            controller: itemController,
            hintText: "Item",
          ),
          MySpacing(height: 15),

          //Color Selection
          MiddleMessage(message: "Priority"),
          MySpacing(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ItemColorPicker(
                currIndex: 0,
                selectedIndex: selectedIndex,
                itemColor: itemColors[0],
                changeSelected: changeColorIndex,
                setState: setState,
              ),
              _ItemColorPicker(
                currIndex: 1,
                selectedIndex: selectedIndex,
                itemColor: itemColors[1],
                changeSelected: changeColorIndex,
                setState: setState,
              ),
              _ItemColorPicker(
                currIndex: 2,
                selectedIndex: selectedIndex,
                itemColor: itemColors[2],
                changeSelected: changeColorIndex,
                setState: setState,
              ),
            ],
          ),

          //Due Date
          MySpacing(height: 10),
          MyButton(
            fontSize: fontSizeMedium * 0.8,
            text: dueDateText,
            onTap: () {
              // DateTime

              _dateTimePicker(
                context: context,
                onConfirm: (dateTime) => dueDate = dateTime,
              );
            },
          ),
          // extraWidget ?? Container(width: 0, height: 0),
        ],
        buttons: [
          MyAlertButton(
            onTap: () {
              onConfirm(
                itemController: itemController,
                dueDate: dueDate,
                itemColors: itemColors,
                selectedIndex: selectedIndex,
              );
            },
            text: confirmButtonText,
          ),
          MyAlertButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "Cancel",
          )
        ],
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return getAlertDialog(context, setState);
        });
      },
    );
  }

  void _addItem({
    required String name,
    required DateTime dueDate,
    required ItemStatus status,
    required ItemColor color,
  }) {
    FirestoreService.addItemToCategory(
      name: name,
      dueDate: dueDate,
      status: status,
      color: color,
      categoryDocId: _category.documentID,
    );

    notifyListeners();
  }

  void _changeItem({
    required String name,
    required DateTime dueDate,
    required ItemStatus status,
    required ItemColor color,
    required Item item,
  }) {
    FirestoreService.changeItemFromCategory(
      name: name,
      dueDate: dueDate,
      status: status,
      color: color,
      categoryDocId: _category.documentID,
      itemDocId: item.documentID,
    );

    notifyListeners();
  }

  void _deleteItem({required BuildContext context, required Item item}) {
    FirestoreService.deleteItem(item);
    notifyListeners();
    Navigator.pop(context);
  }

  void setCategory(Category category) {
    _category = category;
  }
}

class _ItemColorPicker extends StatefulWidget {
  final ItemColor itemColor;
  final int selectedIndex;
  final int currIndex;
  final Function changeSelected;
  final Function setState;

  _ItemColorPicker({
    required this.itemColor,
    required this.selectedIndex,
    required this.currIndex,
    required this.changeSelected,
    required this.setState,
  });

  @override
  __ItemColorPickerState createState() => __ItemColorPickerState();
}

class __ItemColorPickerState extends State<_ItemColorPicker> {
  @override
  Widget build(BuildContext context) {
    final bool isSelected = this.widget.currIndex == this.widget.selectedIndex;

    return GestureDetector(
      onTap: () {
        this.widget.changeSelected(
            newSelectedIndex: this.widget.currIndex,
            setState: this.widget.setState);
      },
      child: Container(
        padding: EdgeInsets.all(7),
        // height: 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (isSelected)
              ? Item.getColorByItemColor(this.widget.itemColor)
              : darkNavyBlue,
          borderRadius: borderRadius,
          border: Border.all(width: 1.0, color: brightRed.withAlpha(128)),
        ),
        child: Text(
          Item.getPriority(this.widget.itemColor),
          textAlign: TextAlign.center,
          textScaleFactor: 0.8,
          style: TextStyle(
            fontFamily: fontMont,
            fontSize: fontSizeSmall,
            color: (isSelected)
                ? ((this.widget.itemColor == ItemColor.Yellow)
                    ? Colors.white
                    : mustard)
                : mustard,
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> _dateTimePicker(
    {required BuildContext context,
    required Function(DateTime) onConfirm}) async {
  return await DatePicker.showDateTimePicker(
    context,
    currentTime: DateTime.now(),
    locale: LocaleType.en,
    minTime: DateTime.now(),
    maxTime: DateTime(2499),
    theme: DatePickerTheme(
      backgroundColor: darkNavyBlue,
      headerColor: brightRed,
      cancelStyle: TextStyle(
        color: Colors.orange[200],
        fontWeight: FontWeight.bold,
        fontSize: fontSizeLarge,
        fontFamily: fontPacifico,
      ),
      itemStyle: TextStyle(
        color: Colors.white,
        fontFamily: fontMont,
      ),
      doneStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.orange[200],
        fontSize: fontSizeMedium,
        fontFamily: fontPacifico,
      ),
    ),
    onConfirm: onConfirm,
  );
}
