import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/screens/download_screen/components/body_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'components/body.dart';

class DownloadScreen extends StatelessWidget {
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
          return kIsWeb ? BodyWeb() : Body(state);
        }
    );
  }
}
