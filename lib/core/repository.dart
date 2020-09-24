import '../core/utils/disposable.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import './jsonModel.dart';

abstract class Repo extends Disposable {
  BehaviorSubject _dataStream;
  SharedPreferences _sharedPreferences;

  Repo(BehaviorSubject subject)
      : _sharedPreferences = GetIt.instance.get(),
        _dataStream = subject;

  getPreference<T>(String key) {
    if (T == String)
      return _sharedPreferences.getString(key);
    else if (T == bool)
      return _sharedPreferences.getBool(key);
    else if (T == int)
      return _sharedPreferences.getInt(key);
    else if (T == double)
      return _sharedPreferences.getDouble(key);
    else if (T == List)
      return _sharedPreferences.getStringList(key);
    else {
      print(
          "Get Preference Method. Either you didn't specify type or something went wrong");
      return null;
    }
  }

  Future<bool> setPreference<T>(String key, value) async {
    if (T == String)
      return await _sharedPreferences.setString(key, value);
    else if (T == bool)
      return await _sharedPreferences.setBool(key, value);
    else if (T == int)
      return await _sharedPreferences.setInt(key, value);
    else if (T == double)
      return await _sharedPreferences.setDouble(key, value);
    else if (T == List)
      return await _sharedPreferences.setStringList(key, value);
    else {
      print(
          "Set Preference Method. Either you didn't specify type or something went wrong");
      return null;
    }
  }
}

class ItemRepo<T extends JSONModel> extends Repo {
  ItemRepo(BehaviorSubject<T> subject) : super(subject);

  BehaviorSubject<T> get dataStream {
    return _dataStream;
  }

  T get subjectValue => _dataStream.value;

  void updateStream(T t) => _dataStream.add(t);

  Stream<S> getStream<S>(S Function(dynamic) map) => _dataStream.map(map);

  @override
  void dispose() {
    dataStream.close();
  }
}

class ListRepo<T> extends Repo {
  ListRepo(BehaviorSubject<List<T>> subject) : super(subject);

  BehaviorSubject<List<T>> get dataStream => _dataStream;

  void updateStream(List<T> t) => _dataStream.add(t);

  Stream<S> getStream<S>(S Function(dynamic) map) => _dataStream.map(map);

  @override
  void dispose() {
    dataStream.close();
  }
}