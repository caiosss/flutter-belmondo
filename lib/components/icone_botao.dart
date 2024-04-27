import 'package:flutter/material.dart';

class IconeBotao extends StatelessWidget {
  final Icon icone;
  final void Function() funcaoChamada;

  IconeBotao(this.icone, this.funcaoChamada);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: funcaoChamada,
      icon: icone,
      style: const ButtonStyle(
        iconColor: MaterialStatePropertyAll(Colors.black),
      ),
    );
  }
}
