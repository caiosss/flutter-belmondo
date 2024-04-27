import 'package:aplicacao_mobile/components/icone_botao.dart';
import 'package:flutter/material.dart';

//container que precisa ser alterado para ajustar as configurações!!

class SetContainer extends StatelessWidget {
  final String text;
  final IconeBotao icone;
  

  SetContainer(this.text, this.icone);

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
          icone,
        ],
      ),
    );
  }
}
