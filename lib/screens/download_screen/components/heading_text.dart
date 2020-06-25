import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: 'Download your ',
                style: TextStyle(
                  fontSize: 32.0,
                  color: kCommentColor,
                ),
                children: [
                  TextSpan(
                    text: 'books',
                    style: TextStyle(
                      fontSize: 42.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ]
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: 'from the ',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: kCommentColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'cloud',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
