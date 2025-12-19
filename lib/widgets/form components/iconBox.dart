import 'package:flutter/material.dart';

Widget iconBox({required IconData icon, required Color color}) {
  return Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      color: Colors.deepPurple[50],
      borderRadius: BorderRadius.circular(35),
      border: Border.all(color: Colors.grey[300]!, width: 1),
    ),
    child: Icon(icon, size: 30, color: color),
  );
}
