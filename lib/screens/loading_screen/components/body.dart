import 'dart:math';

import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Hero(
          tag: 'logo',
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud,
                  color: kBackgroundColor,
                  size: min(48.0, size.width / 15),
                ),
                SizedBox(width: 8.0),
                Text(
                  'CloudReader',
                  style: TextStyle(
                    color: kBackgroundColor,
                    fontSize: min(48.0, size.width / 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
