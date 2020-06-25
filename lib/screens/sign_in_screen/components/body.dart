import 'dart:math';

import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(size),
            SizedBox(height: size.height * 0.05),
            buildSignInWithGoogleButton(context),
          ],
        ),
      ),
    );
  }

  RaisedButton buildSignInWithGoogleButton(BuildContext context) {
    return RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            icon: Icon(
              FontAwesomeIcons.google,
              color: kSecondaryColor,
            ),
            label: Text(
              'Sign in with Google',
              style: TextStyle(color: kSecondaryColor),
            ),
            color: kBackgroundColor,
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationSignInWithGoogleButtonPressed()),
          );
  }

  Widget buildLogo(Size size) {
    return Hero(
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
    );
  }
}
