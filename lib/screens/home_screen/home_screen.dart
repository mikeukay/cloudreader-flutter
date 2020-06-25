import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (BuildContext context, BooksState state) {
        if(state is BooksLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if(state is BooksLoadFailure) {
          return Center(child: Text('Something went wrong :('));
        }
        return Body();
      }
    );
  }
}

