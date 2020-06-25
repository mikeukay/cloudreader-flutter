import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CacheRepository {
  SharedPreferences _prefs;

  Future<void> initialize() async {
    if(!kIsWeb) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  String getPath(String bookId) {
    if(_prefs == null || !_prefs.containsKey(bookId)) { return null; }
    return _prefs.getString(bookId);
  }

  Future<void> setPath(String bookId, String path) async {
    if(_prefs == null) { return null; }
    return _prefs.setString(bookId, path);
  }

  Future<void> removePath(String bookId) async {
    if(_prefs == null || !_prefs.containsKey(bookId)) {return Future.value();}
    return _prefs.remove(bookId);
  }
}