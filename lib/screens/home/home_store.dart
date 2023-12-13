import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  ObservableList<String> savedRecords = ObservableList<String>();

  @action
  void addRecord(String record) {
    savedRecords.add(record);
  }

  @action
  void removeRecord(String record) {
    savedRecords.remove(record);
  }

  String newMethod(String email) => email;

  @action
  void openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: savedRecords.length,
              itemBuilder: (_, index) {
                final record = savedRecords[index];
                return ListTile(
                  title: Text(record),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeRecord(record);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
