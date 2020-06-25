import 'package:cloudreader/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksLoad extends BooksEvent {}

class BookUpdated extends BooksEvent {
  final Book oldBook;
  final Book newBook;

  const BookUpdated(this.oldBook, this.newBook);

  @override
  List<Object> get props => [oldBook, newBook];

  @override
  String toString() => 'BookUpdated { oldBook: $oldBook, newBook: $newBook }';
}

class BookDeleted extends BooksEvent {
  final Book book;

  const BookDeleted(this.book);

  @override
  List<Object> get props => [book];

  @override
  String toString() => 'BookDeleted { book: $book }';
}

class BookDownloaded extends BooksEvent {
  final Book book;

  const BookDownloaded(this.book);

  @override
  List<Object> get props => [book];

  @override
  String toString() => 'BookDownloaded { book: $book }';
}

class BooksUpdated extends BooksEvent {
  final List<Book> books;

  BooksUpdated(this.books);

  @override
  List<Object> get props => [books];

  @override
  String toString() => 'BooksUpdated { books: $books }';
}