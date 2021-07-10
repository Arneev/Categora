import 'dart:async';

import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/items/widgets/itemWidget.dart';
import 'package:categora/ui/widgets/addCircle.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/middleMessage.dart';
import 'package:categora/ui/widgets/navBar.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'items.modelview.dart';

class ItemsView extends StatefulWidget {
  late final Category category;
  final StreamController<List<Item>> itemController =
      StreamController<List<Item>>.broadcast();

  ItemsView({required this.category});

  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemsViewModel>.reactive(
      viewModelBuilder: () => ItemsViewModel(),
      onDispose: () => this.widget.itemController.close(),
      onModelReady: (model) {
        model.setCategory(this.widget.category);
        model.setController(this.widget.itemController);
        model.listenToItemsByCategory(
            categoryDocumentID: this.widget.category.documentID);
      },
      // onDispose: ()=>,
      builder: (
        BuildContext context,
        ItemsViewModel model,
        _,
      ) {
        return MyScaffold(
          navBar: MyNavBar(),
          body: Column(
            children: [
              MySpacing(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Heading(this.widget.category.name),
                  MySpacing(height: 5),
                  _AddItem(model: model, category: this.widget.category),
                ],
              ),
              MySpacing(),
              (ItemsViewModel.items.length == 0)
                  ? MiddleMessage(message: "No Items...")
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: ItemsViewModel.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ItemWidget(
                              model: model,
                              itemDocumentID:
                                  ItemsViewModel.items[index].documentID,
                            ),
                            MySpacing(height: 15),
                          ],
                        );
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}

class _AddItem extends StatelessWidget {
  final ItemsViewModel model;
  final Category category;

  _AddItem({required this.model, required this.category});

  @override
  Widget build(BuildContext context) {
    return AddCircle(onTap: () => model.addItem(context: context));
  }
}
