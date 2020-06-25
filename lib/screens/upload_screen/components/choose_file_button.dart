import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class ChooseFileButton extends StatelessWidget {
  final Function onTap;

  const ChooseFileButton({
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton.icon(
          onPressed: onTap,
          color: kBackgroundColor,
          focusColor: kBackgroundColor,
          disabledColor: kBackgroundColor,
          hoverColor: kBackgroundColor,
          splashColor: kPrimaryColor,
          icon: Icon(
            Icons.add_circle_outline,
            color: kPrimaryColor,
          ),
          label: Text(
            'Choose file',
            style: TextStyle(color: kPrimaryColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: kPrimaryColor,
              width: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}

