import 'package:cloudreader/blocs/navigation_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;

  const BottomNavigationBarWidget({Key key, this.currentIndex, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kBackgroundColor,
      currentIndex: currentIndex,
      items: items,
      onTap: (int newIndex) {
        if(newIndex != currentIndex) {
          BlocProvider.of<NavigationBloc>(context).add(NavigationRouteIndexChanged(newIndex));
        }
      },
    );
  }
}
