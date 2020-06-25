import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BookUploadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookUploadNameChanged extends BookUploadEvent {
  final String newName;

  BookUploadNameChanged(this.newName);

  @override
  List<Object> get props => [newName];
}

class BookUploadFileChanged extends BookUploadEvent {
  final File newFile;

  BookUploadFileChanged(this.newFile);

  @override
  List<Object> get props => [newFile];
}

class BookUploadSubmitPressed extends BookUploadEvent {
  final String name;
  final File file;

  BookUploadSubmitPressed(this.name, this.file);

  @override
  List<Object> get props => [name, file];
}