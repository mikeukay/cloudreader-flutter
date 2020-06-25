import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/blocs/navigation_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:cloudreader/models/custom_route.dart';
import 'package:cloudreader/repositories/books_repository.dart';
import 'package:cloudreader/repositories/cache_repository.dart';
import 'package:cloudreader/screens/download_screen/download_screen.dart';
import 'package:cloudreader/screens/home_screen/home_screen.dart';
import 'package:cloudreader/screens/loading_screen/loading_screen.dart';
import 'package:cloudreader/screens/sign_in_screen/sign_in_screen.dart';
import 'package:cloudreader/screens/upload_screen/upload_screen.dart';
import 'package:cloudreader/screens/wraper_screen/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/books_bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CloudReader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()..add(AuthenticationInitialize()),
          ),
          BlocProvider<NavigationBloc>(
            create: _generateNavigationBloc,
          )
        ],
        child:App(),
      ),
    );
  }

  NavigationBloc _generateNavigationBloc(BuildContext ctx) {
    NavigationBloc bloc = new NavigationBloc();
    bloc.add(NavigationRouteAdded(
      route: CustomRoute(
        routeName: '/',
        routeScreen: HomeScreen(),
        routeBottomNavBarItem: BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Read')
        ),
      ),
    ));
    bloc.add(NavigationRouteAdded(
      route: CustomRoute(
        routeName: '/upload',
        routeScreen: UploadScreen(),
        routeBottomNavBarItem: BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            title: Text('Upload')
        ),
      ),
    ));
    bloc.add(NavigationRouteAdded(
      route: CustomRoute(
        routeName: '/download',
        routeScreen: DownloadScreen(),
        routeBottomNavBarItem: BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            title: Text('Download')
        ),
      ),
    ));
    return bloc;
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if(state is AuthenticationLoading) {
          return LoadingScreen();
        } else if(state is AuthenticationFailure) {
          return SignInScreen();
        } else if(state is AuthenticationSuccess) {
          return BlocProvider<BooksBloc>(
            create: (context) {
              return BooksBloc(booksRepository: BooksRepository(
                uid: state.user.uid,
                cacheRepository: CacheRepository(),
              ))..add(BooksLoad());
            },
            child: WrapperScreen(),
          );
        }
        return Scaffold();
      },
    );
  }
}

