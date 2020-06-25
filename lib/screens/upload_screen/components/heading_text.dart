import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final bool usePadding;

  const HeadingText(this.text, {
    this.usePadding = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            // color: kCommentColor,
            fontSize: 24.0,
          ),
        ),
        usePadding ? SizedBox(height: 8.0) : Container(),
      ],
    );
  }
}
