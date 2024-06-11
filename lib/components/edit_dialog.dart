import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';
import 'package:aplicacao_mobile/components/edit_dialog_box.dart';

class EditDialog extends StatefulWidget {
  final String nome;
  final String id;
  final String senha;
  final String email;
  final bool isAdm;
  EditDialog(this.nome, this.email, this.senha, this.isAdm, this.id);

  @override
  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  int _selectedValue = 1;

  void _showEditDialog(String texto, String name, String email, String password, bool isAdm, String id) {
    showDialog(
      context: context,
      builder: (context) => EditarDadoDialog(texto, name, email, password, isAdm, id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Escolha qual dado voce deseja editar:'),
      content: Column(children: [
        ListTile(
          title: const Text('Nome'),
          leading: Radio<int>(
            value: 1,
            groupValue: _selectedValue,
            onChanged: (int? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('email'),
          leading: Radio<int>(
            value: 2,
            groupValue: _selectedValue,
            onChanged: (int? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('senha'),
          leading: Radio<int>(
            value: 3,
            groupValue: _selectedValue,
            onChanged: (int? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
        ),
      ],),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Continuar'),
          onPressed: () {
              if(_selectedValue == 1){
                  _showEditDialog('nome', widget.nome, widget.email, widget.senha, widget.isAdm, widget.id);
              } else if(_selectedValue == 2){
                  _showEditDialog('email', widget.nome, widget.email, widget.senha, widget.isAdm, widget.id);
              } else if(_selectedValue == 3){
                  _showEditDialog('senha', widget.nome, widget.email, widget.senha, widget.isAdm, widget.id);
              }
          },
        ),
      ],
    );
  }
}
