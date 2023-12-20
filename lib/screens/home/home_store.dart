import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String phone = '';

  @observable
  bool showList = false;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPhone(String value) => phone = value;

  @action
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return email.isNotEmpty && emailRegex.hasMatch(email);
  }

  @action
  bool isValidData() {
    return name.isNotEmpty && isValidEmail() && phone.isNotEmpty;
  }

  @action
  void saveData() {
    final String record = '$name|$email|$phone';
    savedRecords.add(record);
  }

  @action
  void updateRecord(String oldRecord) {
    final index = savedRecords.indexOf(oldRecord);
    if (index != -1) {
      savedRecords[index] = '$name|$email|$phone';
    }
  }

  @action
  void removeRecord(String record) {
    savedRecords.remove(record);
  }

  @observable
  ObservableList<String> savedRecords = ObservableList<String>();
}
