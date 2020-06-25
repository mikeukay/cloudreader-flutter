import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/blocs/book_upload_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold handled by the wrapper screen
    return BlocProvider<BookUploadBloc>(
      create: (context) => BookUploadBloc(uid: BlocProvider.of<AuthenticationBloc>(context).state.user.uid),
      child:  Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Body(),
      )
    );
  }
}