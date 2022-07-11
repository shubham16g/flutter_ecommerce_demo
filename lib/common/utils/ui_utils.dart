

import 'package:flutter/material.dart';

extension UiUtils on BuildContext {
  void showSnackbar(String title){
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(title),
    ));
  }
}
