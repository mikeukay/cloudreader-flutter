import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(size: size)
    );
  }
}