import 'package:cloudreader/blocs/authentication_bloc/bloc.dart';
import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'book_list.dart';
import 'heading_text.dart';
import '../logic/book_open.dart' as BookOpener;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    List<Book> books = BlocProvider.of<BooksBloc>(context).state.books;
    if(!kIsWeb) { books = books.where((element) => element.localPath != null).toList(); }
    if(books.length == 0) {
      return Center(
        child: Text('Couldn\'t find any books. Get some!'),
      );
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: HeadingText(name: user.displayName),
            height: 115.0,
          ),
          Container(
            height: constraints.maxHeight - 115.0,
            child: BookList(
              books: books,
              openBookFunction: kIsWeb ? BookOpener.openBookWeb : BookOpener.openBook
            ),
          ),
        ],
      ),
    );
  }
}