import 'package:fluttertoast/fluttertoast.dart';

void toast(dynamic msg) {
  Fluttertoast.showToast(msg: msg.toString());
}
