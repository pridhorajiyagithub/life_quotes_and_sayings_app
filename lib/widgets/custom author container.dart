import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAuthorContainer({required double height, required String author}) {
  return Container(
    height: height * 0.230,
    decoration: BoxDecoration(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(0.5),
      borderRadius: BorderRadius.circular(7),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      author,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
