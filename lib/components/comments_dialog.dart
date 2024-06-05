import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';

class EditarDadoDialog extends StatefulWidget {
  final String forumId;

  EditarDadoDialog(this.forumId);

  @override
  _EditarDadoDialogState createState() => _EditarDadoDialogState();
}

class _EditarDadoDialogState extends State<EditarDadoDialog> {
  String comentario = '';
  final dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Digite seu comentario:'),
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (text) {
          setState(() {
            comentario = text;
          });
        },
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () {
              
          },
        ),
      ],
    );
  }
}
