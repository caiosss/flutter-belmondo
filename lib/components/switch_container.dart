import 'package:flutter/material.dart';

//container que precisa ser alterado para ajustar as configurações!!

class SwitchContainer extends StatelessWidget {
  final String text;
  final Switch botao;  

  SwitchContainer(this.text, this.botao);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          botao,
        ],
      ),
    );
  }
}
