import 'package:flutter/material.dart';

Widget keywordChips(context, keywords) {
  return Wrap(
    spacing: 10,
    children: List.generate(
      keywords!.length,
      (index) => Chip(
        backgroundColor: Colors.white,
        label: Text(keywords![index],
            softWrap: true,
            style: TextStyle(
                overflow: TextOverflow.fade,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    ),
  );
}
