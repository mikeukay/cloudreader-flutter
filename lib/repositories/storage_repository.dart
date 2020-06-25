import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final String uid;
  final StorageReference userDir;

  StorageRepository({this.uid}) : this.userDir = FirebaseStorage().ref().child(uid);

  Future<String> uploadBook(File localBookFile, String id) async {
    final String filename = id + '.pdf';
    StorageUploadTask uploadTask = this.userDir.child(filename).putFile(
        localBookFile
    );
    StorageTaskSnapshot snap = await uploadTask.onComplete;
    return (await snap.ref.getDownloadURL()).toString();
  }

  Future<void> deleteBook(String id) async {
    final String filename = id + '.pdf';
    return this.userDir.child(filename).delete();
  }

}