import 'package:fluttertoast/fluttertoast.dart';

void showShortToast(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}
