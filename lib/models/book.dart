import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String name;
  final String downloadURL;
  final int currentPage;
  final String localPath;

  Book({this.id, this.name, this.downloadURL, this.currentPage = 0, this.localPath});

  @override
  List<Object> get props => [id, name, currentPage, localPath];

  @override
  String toString() => 'Book { name: $name, currentPage: $currentPage, localPath: $localPath }';

  Map<String, dynamic> get asDocument {
    return {'id': id, 'name': name, 'downloadURL': downloadURL, 'currentPage': currentPage};
  }

  static Book fromDocument(Map<String, dynamic> doc) {
    return Book(id: doc['id'], name: doc['name'], downloadURL: doc['downloadURL'], currentPage: doc['currentPage']);
  }

  Book copyWith({String localPath, String name, int currentPage}) {
    return Book(
      id: this.id,
      name: name ?? this.name,
      downloadURL: this.downloadURL,
      currentPage: currentPage ?? this.currentPage,
      localPath: localPath ?? this.localPath,
    );
  }
}