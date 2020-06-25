import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/repositories/books_repository.dart';
import 'package:cloudreader/repositories/storage_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'book_upload_event.dart';
import 'book_upload_state.dart';
import 'validators.dart';

class BookUploadBloc extends Bloc<BookUploadEvent, BookUploadState> {
  final String uid;
  final StorageRepository _storageRepository;
  final BooksRepository _booksRepository;

  BookUploadBloc({
    String uid,
    StorageRepository storageRepository,
    BooksRepository booksRepository
  }) : assert(uid != null),
  _storageRepository = storageRepository ?? StorageRepository(uid: uid),
  _booksRepository = storageRepository ?? BooksRepository(uid: uid),
  this.uid = uid;


  @override
  BookUploadState get initialState => BookUploadState.initial();

  @override
  Stream<Transition<BookUploadEvent, BookUploadState>> transformEvents(
      Stream<BookUploadEvent> events,
      TransitionFunction<BookUploadEvent, BookUploadState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! BookUploadNameChanged);
    });
    final debounceStream = events.where((event) {
      return (event is BookUploadNameChanged);
    }).debounceTime(Duration(milliseconds: 250));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<BookUploadState> mapEventToState(BookUploadEvent event) async* {
    if(event is BookUploadNameChanged) {
      yield* _mapBookUploadNameChangedToState(event);
    } else if(event is BookUploadFileChanged) {
      yield* _mapBookUploadFileChangedToState(event);
    } else if(event is BookUploadSubmitPressed) {
      yield* _mapBookUploadSubmitPressedToState(event);
    }
  }

  Stream<BookUploadState> _mapBookUploadNameChangedToState(BookUploadNameChanged event) async* {
    yield state.update(
      isNameValid: Validators.isNameValid(event.newName),
    );
  }

  Stream<BookUploadState> _mapBookUploadFileChangedToState(BookUploadFileChanged event) async* {
    yield state.update(
      isFileValid: Validators.isFileValid(event.newFile),
    );
  }

  Stream<BookUploadState> _mapBookUploadSubmitPressedToState(BookUploadSubmitPressed event) async* {
    yield BookUploadState.loading();

    try {
      final String uuid = Uuid().v1();
      String url = await _storageRepository.uploadBook(event.file, uuid);
      Book book = new Book(
        id: uuid,
        name: event.name,
        downloadURL: url,
        currentPage: 0
      );
      await _booksRepository.addNewBook(book);
      yield BookUploadState.success();
    } catch(_) {
      print(_.toString());
      yield BookUploadState.failure();
    }
  }
}