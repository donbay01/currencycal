// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

displayToastMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
    ),
    backgroundColor: Colors.green,
  ));
}
