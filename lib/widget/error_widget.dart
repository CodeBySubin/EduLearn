import 'package:flutter/material.dart';

Widget errorWidget(String text) {
  return Center(
    child: Text(text, style: const TextStyle(color: Colors.red, fontSize: 16)),
  );
}
