import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const ForumApp());

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Forum(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => ForumState();
}

class ForumState extends State<Forum> {
  final double coverHeight = 274;
  final double forumHeight = 144;
  final double forumWidth = 180;

  int itemSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        buildTop(),
        buildContent(),
      ],
    ));
  }

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 180 / 2),
          child: buildCover(),
        ),
        Positioned(
          top: coverHeight - 120 / 2,
          left: forumWidth - 160,
          child: buildAvatar(),
        ),
      ],
    );
  }

  Widget buildCover() => Container(
        color: Color.fromARGB(255, 2, 40, 70),
        height: coverHeight,
      );

  Widget buildAvatar() => const CircleAvatar(
        radius: 60,
        backgroundColor: Color.fromARGB(255, 4, 112, 194),
        child: Icon(
          Icons.picture_in_picture_alt,
          size: 80,
          color: Colors.black,
        ),
      );

  Widget buildContent() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Fórum #1",
                  style: TextStyle(
                    fontSize: 38,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "O Fórum tal possui penis largos",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ],
        ),
      );
}
