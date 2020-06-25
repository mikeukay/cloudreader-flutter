import 'dart:async';

import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/blocs/books_bloc/books_bloc.dart';
import 'package:cloudreader/bottom_sheets/book_bottom_sheet.dart';
import 'package:cloudreader/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListWidget extends StatefulWidget {
  const BookListWidget({
    Key key,
    @required this.books,
  }) : super(key: key);

  final List<Book> books;

  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<String> downloading;

  @override
  void initState() {
    downloading = new List<String>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.books.length,
      itemBuilder: (BuildContext ctx, int index) {
        Book b = widget.books[index];
        bool isDownloading = downloading.contains(b.id);
        return _buildListTile(b, isDownloading, context, index, ctx);
      },
    );
  }

  Padding _buildListTile(Book b, bool isDownloading, BuildContext context, int index, BuildContext ctx) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListTile(
          leading: Icon(Icons.cloud),
          title: Text(b.name),
          trailing: isDownloading ? CircularProgressIndicator() : IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              BlocProvider.of<BooksBloc>(context).add(BookDownloaded(b));
              setState(() {
                downloading.add(b.id);
              });
            },
          ),
          onLongPress: () async {
            showBookEditBottomSheet(ctx, b, BlocProvider.of<BooksBloc>(context));
          },
        ),
      );
  }
}

