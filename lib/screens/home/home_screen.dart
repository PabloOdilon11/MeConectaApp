import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/widgets/action_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_store.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = HomeStore();

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
              ActionButton(
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
                        content: Text(
                            'Por favor, preencha todos os campos corretamente!',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                title: 'Enviar',
                backgroundColor: Colors.blue,
                decoration: 'Enviar2',
              ),
              SizedBox(height: 20),
              ActionButton(
                onPressed: () {
                  _showListDialog(context);
                },
                backgroundColor: Colors.blue,
                title: 'Listar',
                decoration: 'Listar',
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
