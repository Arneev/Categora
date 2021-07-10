import 'package:categora/classes/category.class.dart';
import 'package:categora/services/Router.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/categories/categories.viewmodel.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  late final Category category;
  CategoriesViewModel model;

  CategoryWidget({required this.category, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onLongPress: () => model.updateCategory(context, category),
      onTap: () => goToItems(context, category),
      child: Container(
        width: size.width * 0.8,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(
            color: brightRed,
          ),
          borderRadius: borderRadius,
        ),
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mustard,
            fontSize: fontSizeMedium,
            fontFamily: fontMont,
          ),
        ),
      ),
    );
  }
}
