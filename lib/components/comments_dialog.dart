import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';

class ComentDialog extends StatefulWidget {
  final String forumId;

  ComentDialog(this.forumId);

  @override
  _ComentDialogState createState() => _ComentDialogState();
}

class _ComentDialogState extends State<ComentDialog> {
  String comentario = '';
  final dbService = UserDatabaseService();

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
