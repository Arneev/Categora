import 'package:flutter/material.dart';

import '../../style.dart';

class MyDropDown extends StatefulWidget {
  final Function(String) onChanged;
  final String hint;
  final List<String> list;
  final String startingValue;

  MyDropDown({
    required this.onChanged,
    required this.hint,
    required this.list,
    required this.startingValue,
  });

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.5,
      decoration: BoxDecoration(
        color: darkNavyBlue,
        border: Border.all(width: 2.0, color: brightRed),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: DropdownButton<String>(
        dropdownColor: darkNavyBlue,
        onChanged: (newValue) {
          if (newValue != null) {
            this.widget.onChanged(newValue);
          }
        },
        value: this.widget.startingValue,
        hint: _FilterText(
          text: this.widget.hint,
        ),
        items: this.widget.list.map(
          (String option) {
            return DropdownMenuItem(
              value: option,
              child: _FilterText(
                text: option,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class _FilterText extends StatelessWidget {
  final String text;

  _FilterText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: mustard,
        fontFamily: fontMont,
        fontSize: fontSizeSmall,
      ),
    );
  }
}
