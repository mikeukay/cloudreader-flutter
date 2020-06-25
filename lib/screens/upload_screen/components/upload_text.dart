import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class UploadText extends StatelessWidget {
  const UploadText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Upload a new ',
          style: TextStyle(
            color: kCommentColor,
            fontSize: 32,
          ),
          children: [
            TextSpan(
                text: 'book.',
                style: TextStyle(
                  fontSize: 42,
                  color: kPrimaryColor,
                )
            )
          ]
      ),
    );
  }
}
