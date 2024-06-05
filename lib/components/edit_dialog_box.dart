import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';




class EditarDadoDialog extends StatefulWidget {
  final String nome;
  final String text;
  final String id;
  final String senha;
  final String email;
  final bool isAdm;

  EditarDadoDialog(this.text, this.nome, this.email, this.senha, this.isAdm, this.id);

  @override
  _EditarDadoDialogState createState() => _EditarDadoDialogState();
}

class _EditarDadoDialogState extends State<EditarDadoDialog> {
  String _novoAtributo = '';
  final dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar ${widget.text}'),
      content: TextField(
        decoration: InputDecoration(
          labelText: 'Novo ${widget.text}',
          border: OutlineInputBorder(),
        ),
        onChanged: (text) {
          setState(() {
            _novoAtributo = text;
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
            var user;
            if(widget.text=="nome"){
                user = UserModel(id: widget.id.toString(), name: _novoAtributo, email: widget.email, password: widget.senha, isAdm: widget.isAdm);
                dbService.editUser(user);        
            } else if(widget.text == "senha"){
                user = UserModel(id: widget.id.toString(), name: widget.nome, email: widget.email, password: _novoAtributo, isAdm: widget.isAdm);
                dbService.editUser(user);        
            } else if(widget.text == "email"){
                user = UserModel(id: widget.id.toString(), name: widget.nome, email: _novoAtributo, password: widget.senha, isAdm: widget.isAdm);
            }
          },
        ),
      ],
    );
  }
}