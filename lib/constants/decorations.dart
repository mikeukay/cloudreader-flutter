import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

InputDecoration kInputDecoration = InputDecoration(
  filled: false,
  contentPadding: EdgeInsets.all(8.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 3.0),
  ),
  hintStyle: TextStyle(color: kCommentColor),
  labelStyle: TextStyle(color: kCommentColor),
);