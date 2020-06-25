import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    Key key,
    @required this.enabled,
    @required this.onTap
  }) : super(key: key);

  final bool enabled;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          textColor: kBackgroundColor,
          disabledTextColor: kBackgroundColor,
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Upload', style: TextStyle(fontSize: 21.0)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: enabled ? onTap : null,
        ),
      ),
    );
  }
}