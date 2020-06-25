import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudreader/models/book.dart';
import 'package:cloudreader/repositories/cache_repository.dart';
import 'package:cloudreader/repositories/storage_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class BooksRepository {
  final String uid;
  final DocumentReference userDoc;
  final CacheRepository cacheRepository;

  BooksRepository({this.uid, this.cacheRepository}) : this.userDoc = Firestore.instance.collection("users").document(uid);

  Future<void> initialize() async {
    return cacheRepository.initialize();
  }

  Future<void> addNewBook(Book book) {
    if(book == null) return Future.value();
    return userDoc.updateData({
      "books": FieldValue.arrayUnion([book.asDocument])
    }).catchError((err) {
      return userDoc.setData({
        "books": [book.asDocument],
      });
    });
  }

  Future<void> removeBook(Book book) {
    List<Future> toWait = new List<Future>();
    if(!kIsWeb && book.localPath != null && book.localPath != "") {
      toWait.add(File(book.localPath).delete());
    }

    toWait.add(userDoc.updateData({
      "books": FieldValue.arrayRemove([book.asDocument])
    }));
    toWait.add(StorageRepository(uid: uid).deleteBook(book.id));
    toWait.add(cacheRepository.removePath(book.id));

    return Future.wait(toWait);
  }

  Stream<List<Book>> books() {
    return userDoc.snapshots().map((DocumentSnapshot snapshot) {
      List<Book> l = new List<Book>();
      if(!snapshot.exists) { return l; }
      List<dynamic> books = snapshot.data['books'];
      for (int i = 0; i < books.length; ++i) {
        Book b = Book.fromDocument(books[i]);
        String localPath = cacheRepository.getPath(b.id);
        if(localPath != null) {
          l.add(b.copyWith(localPath: localPath));
        } else {
          l.add(b);
        }
      }
      return l;
    });
  }

  Future<void> updateBook(Book oldBook, Book newBook) {
    return Firestore.instance.runTransaction((Transaction t) {
      return t.get(userDoc).then((DocumentSnapshot snap) {
        List<dynamic> books = snap.data['books'];
        for(int i = 0;i < books.length; ++i) {
          if(books[i]['id'] == oldBook.id) {
            books[i] = newBook.asDocument;
          }
        }
        return t.update(userDoc, {
          'books': books
        });
      });
    });
  }

  Future<Book> downloadBook(Book toDownload) async {
    if(kIsWeb) {return toDownload;}

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${toDownload.id}.pdf';
    File f = File(filePath);

    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(toDownload.downloadURL));
    client.close();
    var bytes = req.bodyBytes;
    await f.writeAsBytes(bytes);

    cacheRepository.setPath(toDownload.id, filePath);
    return toDownload.copyWith(localPath: filePath);
  }
}