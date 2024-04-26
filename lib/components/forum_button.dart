import 'package:flutter/material.dart';

class ForumButton extends StatelessWidget{
    final String texto;
    final void Function() funcaoChamada;

    ForumButton(this.texto, this.funcaoChamada);

    @override
    Widget build(BuildContext context){
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          child: Text(texto),
          onPressed: funcaoChamada,
        ),
      );
    }
}
