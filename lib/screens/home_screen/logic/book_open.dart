import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/screens/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:http/http.dart' as http;

Future<void> openBook(Book book, BuildContext context, BooksBloc bloc) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoadingScreen()));
  Future<PdfDocument> pdfFuture = PdfDocument.openFile(book.localPath);
  return displayBook(pdfFuture, context, book, bloc);
}

Future<void> openBookWeb(Book book, BuildContext context, BooksBloc bloc) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoadingScreen()));
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(book.downloadURL));
  var bytes = req.bodyBytes;
  Future<PdfDocument> pdfFuture = PdfDocument.openData(bytes);
  return displayBook(pdfFuture, context, book, bloc);
}

void displayBook(Future<PdfDocument> docFuture, BuildContext context, Book book, BooksBloc bloc) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PdfView(
    controller: PdfController(
      document: docFuture,
      initialPage: book.currentPage
    ),
    documentLoader: LoadingScreen(),
    scrollDirection: Axis.vertical,
    onPageChanged: (page) {
      bloc.add(BookUpdated(book, book.copyWith(currentPage: page)));
    },
    pageSnapping: false,
  )));
}