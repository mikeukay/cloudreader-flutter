import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/bottom_sheets/book_bottom_sheet.dart';
import 'package:cloudreader/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookList extends StatelessWidget {
  const BookList({
    Key key,
    @required this.books,
    @required this.openBookFunction
  }) : super(key: key);

  final List<Book> books;
  final Function openBookFunction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (BuildContext ctx, int index) {
        Book b = books[index];
        return _buildListTile(b, ctx);
      },
    );
  }

  Padding _buildListTile(Book b, BuildContext ctx) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListTile(
          leading: Icon(Icons.book),
          title: Text(b.name),
          subtitle: Text('Current page: ' + b.currentPage.toString()),
          onTap: () {
            openBookFunction(b, ctx, BlocProvider.of<BooksBloc>(ctx));
          },
          onLongPress: () {
            showBookEditBottomSheet(ctx, b, BlocProvider.of<BooksBloc>(ctx));
          },
        ),
      );
  }
}
