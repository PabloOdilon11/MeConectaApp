import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart';

part 'mobx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HomeStore homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me Conecta App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
      home: MainScreen(homeStore: homeStore),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  final HomeStore homeStore;

  MainScreen({required this.homeStore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Me Conecta App',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                onChanged: (value) => homeStore.setName(value),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                ],
                maxLength: 50,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Celular'),
                onChanged: (value) => homeStore.setPhone(value),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                maxLength: 15,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'E-mail'),
                onChanged: (value) => homeStore.setEmail(value),
                keyboardType: TextInputType.emailAddress,
                maxLength: 100,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (homeStore.isValidData()) {
                    homeStore.saveData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dados salvos com sucesso!',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, preencha todos os campos!',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Enviar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showListDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text('Listar', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Observer(
                builder: (_) => Visibility(
                  visible: homeStore.showList,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeStore.savedRecords.length,
                    itemBuilder: (context, index) {
                      final record = homeStore.savedRecords[index];
                      final splitRecord = record.split('|');
                      final name = splitRecord[0];
                      final email = splitRecord[1];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            'Nome: $name\nE-mail: $email',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showEditDialog(context, homeStore, record);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  homeStore.removeRecord(record);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lista de Dados Salvos'),
          content: Container(
            width: double.maxFinite,
            child: Observer(
              builder: (_) => ListView.builder(
                shrinkWrap: true,
                itemCount: homeStore.savedRecords.length,
                itemBuilder: (context, index) {
                  final record = homeStore.savedRecords[index];
                  final splitRecord = record.split('|');
                  final name = splitRecord[0];
                  final email = splitRecord[1];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        'Nome: $name\nE-mail: $email',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditDialog(context, homeStore, record);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              homeStore.removeRecord(record);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
      BuildContext context, HomeStore homeStore, String record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Dados'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Nome Completo'),
                    onChanged: (value) => homeStore.setName(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                    ],
                    maxLength: 50,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Celular'),
                    onChanged: (value) => homeStore.setPhone(value),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    maxLength: 15,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onChanged: (value) => homeStore.setEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                homeStore.updateRecord(record);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}

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
  bool isValidData() {
    return name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty;
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
