import 'package:flutter/material.dart';

//container apenas de informações
class InfoContainer extends StatelessWidget {
  final String text;

  InfoContainer(
    this.text,
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 2, 40, 70),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
