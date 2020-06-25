import 'package:cloudreader/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class BooksState extends Equatable {
  final List<Book> books;

  const BooksState(this.books);

  @override
  List<Object> get props => [books.toString()];
}

class BooksLoadInProgress extends BooksState {
  BooksLoadInProgress() : super(null);
}

class BooksLoadFailure extends BooksState {
  BooksLoadFailure() : super(null);
}

class BooksLoadSuccess extends BooksState {
  BooksLoadSuccess(List<Book> books) : super(books);

  @override
  String toString() => 'BooksLoadSuccess { books: $books }';
}