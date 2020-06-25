import 'package:bloc/bloc.dart';
import 'package:cloudreader/models/custom_route.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationNoRoutes();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationRouteAdded) {
      yield* _mapANavigationRouteAddedToState(event);
    } else if(event is NavigationRouteChanged) {
      yield* _mapNavigationRouteChangedToState(event);
    } else if(event is NavigationRouteIndexChanged) {
      yield* _mapNavigationRouteIndexChangedToState(event);
    }
  }

  Stream<NavigationState> _mapANavigationRouteAddedToState(NavigationRouteAdded event) async* {
    List<CustomRoute> newCustomRoutes = state.routes..add(event.route);
    int newCurrentIndex = state.currentIndex;
    if(newCurrentIndex == -1) {
      newCurrentIndex = 0;
    }

    yield NavigationRouteInfoChanged(
      routes: newCustomRoutes,
      currentIndex: newCurrentIndex,
    );
  }

  Stream<NavigationState> _mapNavigationRouteChangedToState(NavigationRouteChanged event) async* {
    List<CustomRoute> newCustomRoutes = state.routes;
    int newCurrentIndex = 0;

    for(int i = 0;i < state.routes.length; ++i) {
      if(state.routes[i].routeName == event.newRoute) {
        newCurrentIndex = i;
        break;
      }
    }

    yield NavigationRouteInfoChanged(
      routes: newCustomRoutes,
      currentIndex: newCurrentIndex,
    );
  }

  Stream<NavigationState> _mapNavigationRouteIndexChangedToState(NavigationRouteIndexChanged event) async* {
    List<CustomRoute> newCustomRoutes = state.routes;
    int newCurrentIndex = 0;

    if(event.newIndex > 0 && event.newIndex < state.routes.length) {
      newCurrentIndex = event.newIndex;
    }

    yield NavigationRouteInfoChanged(
      routes: newCustomRoutes,
      currentIndex: newCurrentIndex,
    );
  }

}