import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/helper.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/tasks/tasks.viewmodel.dart';
import 'package:categora/ui/widgets/dropdown.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/middleMessage.dart';
import 'package:categora/ui/widgets/navBar.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksViewModel>.reactive(
      viewModelBuilder: () => TasksViewModel(),
      onModelReady: (model) => model.getAllItems(),
      builder: (
        BuildContext context,
        TasksViewModel model,
        _,
      ) {
        final size = MediaQuery.of(context).size;
        return MyScaffold(
          isScrollView: true,
          navBar: MyNavBar(),
          body: Container(
            width: size.width,
            // height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Heading("Tasks"),
                    _SelectFilter(model: model),
                  ],
                ),
                (TasksViewModel.items.isEmpty)
                    ? Container(
                        height: size.width * 0.5,
                        child: Center(
                          child: MiddleMessage(message: "No tasks, Hooray!"),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: TasksViewModel.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              MySpacing(height: 10),
                              _ItemWidget(
                                item: TasksViewModel.items[index],
                                model: model,
                              ),
                            ],
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SelectFilter extends StatefulWidget {
  final TasksViewModel model;

  _SelectFilter({required this.model});

  @override
  __SelectFilterState createState() => __SelectFilterState();
}

class __SelectFilterState extends State<_SelectFilter> {
  @override
  Widget build(BuildContext context) {
    return MyDropDown(
      onChanged: (newOption) {
        setState(() {
          this.widget.model.setFilterChoice(newOption);
          this.widget.model.sortItems();
        });
      },
      hint: "Sort By",
      list: this.widget.model.itemFilterOptions,
      startingValue: this.widget.model.filterChosen,
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final Item item;
  final TasksViewModel model;

  _ItemWidget({required this.item, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String dueTime = getDaysHours(item.dueDate.microsecondsSinceEpoch).trim();
    return GestureDetector(
      //OnTap, go to items screen with category
      onTap: () => model.goToItems(item: item, context: context),
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
        ),
        child: (dueTime.length == 0)
            ? Container(
                padding: EdgeInsets.all(1),
                child: Text(
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
                    child: Text(
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
                    child: Text(
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
