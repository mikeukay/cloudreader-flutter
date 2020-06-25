import 'package:cloudreader/models/custom_route.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  final List<CustomRoute> routes;
  final int currentIndex;

  const NavigationState(this.routes, this.currentIndex);

  @override
  List<Object> get props => [routes, currentIndex];
}

class NavigationNoRoutes extends NavigationState {
  NavigationNoRoutes(): super(new List<CustomRoute>(), -1);
}

class NavigationRouteInfoChanged extends NavigationState {
  NavigationRouteInfoChanged({List<CustomRoute> routes, int currentIndex}): super(routes, currentIndex);
}