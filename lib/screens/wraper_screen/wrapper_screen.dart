import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/blocs/navigation_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:cloudreader/models/custom_route.dart';
import 'package:cloudreader/screens/loading_screen/loading_screen.dart';
import 'package:cloudreader/screens/wraper_screen/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        if(state is NavigationNoRoutes) {
          return LoadingScreen();
        }
        CustomRoute currentRoute = state.routes[state.currentIndex];
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Center(
            child: Container(
              width: size.width < 750 ? double.infinity : 750,
              height: double.infinity,
              child: currentRoute.routeScreen,
            ),
          ),
          bottomNavigationBar: BottomNavigationBarWidget(
            currentIndex: state.currentIndex,
            items: state.routes.map((e) => e.routeBottomNavBarItem).toList(),
          ),
        );
      }
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud,
                color: kBackgroundColor,
              ),
              SizedBox(width: 8.0),
              Text(
                'CloudReader',
                style: TextStyle(color: kBackgroundColor),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogOut());
              },
            )
          ],
        );
  }
}
