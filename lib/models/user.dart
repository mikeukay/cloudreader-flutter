import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;

  User({this.uid, this.name});

  @override
  List<Object> get props => [uid, name];

  @override
  String toString() => 'User { uid: $uid, name: $name }';

  String get displayName {
    return name.split(" ") .first;
  }
}