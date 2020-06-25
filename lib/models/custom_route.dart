import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomRoute extends Equatable {
  final String routeName;
  final Widget routeScreen;
  final BottomNavigationBarItem routeBottomNavBarItem;

  CustomRoute({this.routeName, this.routeScreen, this.routeBottomNavBarItem});

  @override
  List<Object> get props => [routeName, routeScreen, routeBottomNavBarItem];

  @override
  String toString() => 'CustomRoute { routeName: $routeName }';
}