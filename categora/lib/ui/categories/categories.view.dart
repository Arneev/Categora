import 'package:categora/classes/category.class.dart';
import 'package:categora/classes/item.class.dart';
import 'package:categora/helpers/enums.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/categories/categories.viewmodel.dart';
import 'package:categora/ui/categories/widgets/categoryWidget.dart';
import 'package:categora/ui/widgets/addCircle.dart';
import 'package:categora/ui/widgets/middleMessage.dart';
import 'package:categora/ui/widgets/button.dart';
import 'package:categora/ui/widgets/heading.dart';
import 'package:categora/ui/widgets/navBar.dart';
import 'package:categora/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () => CategoriesViewModel(),
      onModelReady: (model) {
        model.listenToCategories();
      },
      builder: (
        BuildContext context,
        CategoriesViewModel model,
        _,
      ) {
        return MyScaffold(
          navBar: MyNavBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MySpacing(),
              // Heading w/ Add Category
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Heading("Categories"),
                  MySpacing(height: 5),
                  _AddCategory(model: model),
                ],
              ),

              MySpacing(),

              CategoriesViewModel.categories.isEmpty
                  ? MiddleMessage(message: "There are no categories")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: CategoriesViewModel.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CategoryWidget(
                                model: model,
                                category: CategoriesViewModel.categories[index],
                              ),
                            ),
                            MySpacing(height: 15),
                          ],
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _AddCategory extends StatelessWidget {
  late final CategoriesViewModel model;

  _AddCategory({required this.model});

  @override
  Widget build(BuildContext context) {
    return AddCircle(onTap: () async => await model.addCategory(context));
  }
}
