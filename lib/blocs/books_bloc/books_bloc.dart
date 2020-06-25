import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/repositories/books_repository.dart';

import 'books_event.dart';
import 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository booksRepository;
  StreamSubscription _streamSubscription;

  BooksBloc({this.booksRepository});

  @override
  BooksState get initialState => BooksLoadInProgress();

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    if(event is BooksLoad) {
      yield* _mapBooksLoadToState();
    } else if(event is BookUpdated) {
      yield* _mapBookUpdatedToState(event);
    } else if(event is BookDeleted) {
      yield* _mapBookDeletedToState(event);
    } else if(event is BookDownloaded) {
      yield* _mapBookDownloadedToState(event);
    } else if(event is BooksUpdated) {
      yield* _mapBooksUpdatedToState(event);
    }
  }

  Stream<BooksState> _mapBooksLoadToState() async* {
    await booksRepository.initialize();
    _streamSubscription?.cancel();
    _streamSubscription = booksRepository.books().listen(
            (books) => add(BooksUpdated(books))
    );
  }

  Stream<BooksState> _mapBookUpdatedToState(BookUpdated event) async* {
    await booksRepository.updateBook(event.oldBook, event.newBook);
  }

  Stream<BooksState> _mapBookDeletedToState(BookDeleted event) async* {
    await booksRepository.removeBook(event.book);
  }

  Stream<BooksState> _mapBooksUpdatedToState(BooksUpdated event) async* {
    yield new BooksLoadSuccess(List.from(event.books));
  }

  Stream<BooksState> _mapBookDownloadedToState(BookDownloaded event) async* {
    try {
      Book newBook = await booksRepository.downloadBook(event.book);
      List<Book> books = List.from(state.books);
      for(int i = 0;i < books.length;++i) {
        if(books[i] == event.book) {
          books[i] = newBook;
          break;
        }
      }
      add(BooksUpdated(books));
    } catch(_) {
      print('offline :(');
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

}