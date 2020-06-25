import 'package:cloudreader/models/custom_route.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationRouteAdded extends NavigationEvent {
  final CustomRoute route;

  NavigationRouteAdded({this.route});

  @override
  List<Object> get props => [route];
}

class NavigationRouteChanged extends NavigationEvent {
  final String newRoute;

  NavigationRouteChanged(this.newRoute);

  @override
  List<Object> get props => [newRoute];
}

class NavigationRouteIndexChanged extends NavigationEvent {
  final int newIndex;

  NavigationRouteIndexChanged(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}