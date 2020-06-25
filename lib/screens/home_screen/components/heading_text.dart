import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
                text: 'Hello there, ',
                style: TextStyle(
                  color: kCommentColor,
                  fontSize: 32,
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 42,
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'What are you reading today?',
              style: TextStyle(
                color: kCommentColor,
                fontSize: 24,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
