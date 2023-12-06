// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$savedRecordsAtom =
      Atom(name: '_HomeStoreBase.savedRecords', context: context);

  @override
  ObservableList<String> get savedRecords {
    _$savedRecordsAtom.reportRead();
    return super.savedRecords;
  }

  @override
  set savedRecords(ObservableList<String> value) {
    _$savedRecordsAtom.reportWrite(value, super.savedRecords, () {
      super.savedRecords = value;
    });
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void addRecord(String record) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.addRecord');
    try {
      return super.addRecord(record);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeRecord(String record) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.removeRecord');
    try {
      return super.removeRecord(record);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openModal(BuildContext context) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.openModal');
    try {
      return super.openModal(context);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
savedRecords: ${savedRecords}
    ''';
  }
}
