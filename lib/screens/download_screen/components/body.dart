import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_list_widget.dart';
import 'heading_text.dart';

class Body extends StatelessWidget {
  final BooksState state;

  const Body(this.state, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Book> books = BlocProvider.of<BooksBloc>(context).state.books.where((element) => element.localPath == null).toList();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: HeadingText(),
            height: 120,
          ),
          Container(
            child: books.length > 0 ? new BookListWidget(books: books) : Center(
              child: Text('No books found :(\nTry uploading some!'),
            ),
            height: constraints.maxHeight - 120,
          ),
        ],
      ),
    );
  }
}