import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart';

part 'main.g.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListScreen(homeStore: homeStore),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text('Ver Lista', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  final HomeStore homeStore;

  ListScreen({required this.homeStore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Dados Salvos',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Lista de Dados Salvos:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Observer(
                  builder: (_) => ListView.builder(
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
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              homeStore.removeRecord(record);
                            },
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
}

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String phone = '';

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
  void removeRecord(String record) {
    savedRecords.remove(record);
  }

  @observable
  ObservableList<String> savedRecords = ObservableList<String>();
}
