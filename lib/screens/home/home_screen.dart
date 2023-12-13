import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_store.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore store = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.blue,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Me conecta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                onChanged: (value) => store.addRecord(value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => store.openModal(context),
                child: Text('Abrir Modal'),
              ),
              Observer(
                builder: (_) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: store.savedRecords.length,
                  itemBuilder: (_, index) {
                    final record = store.savedRecords[index];
                    return ListTile(
                      title: Text(record),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showEditDialog(context, record),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => store.removeRecord(record),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Registro'),
          content: TextField(
            controller: TextEditingController(text: record),
            onChanged: (value) {
              // Atualize os dados no estado conforme o usuário digita
            },
            decoration: InputDecoration(labelText: 'Editar Dados'),
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
                // Salve as alterações e atualize a lista
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
