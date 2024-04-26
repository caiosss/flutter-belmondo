import 'package:flutter/material.dart';

class ForumButton extends StatelessWidget {
  final String texto;
  final void Function() funcaoChamada;

  ForumButton(this.texto, this.funcaoChamada);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: funcaoChamada,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.grey,
        ),
        child: Text(texto),
      ),
    );
  }
}
