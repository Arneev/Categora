import 'package:categora/ui/tasks/tasks.viewmodel.dart';
import 'package:categora/ui/widgets/heading.dart';
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
      builder: (
        BuildContext context,
        TasksViewModel model,
        _,
      ) {
        return MyScaffold(
          navBar: MyNavBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Heading("Tasks"),
            ],
          ),
        );
      },
    );
  }
}
