import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/forum_button.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int itemSelecionado = 0;

  void tapItem(int index) {
    setState(() {
      itemSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 130,
        backgroundColor: Colors.lightBlue,
        leading: Icon(Icons.person),
        title: SearchBar(
          keyboardType: TextInputType.text,
          hintText: "Pesquise aqui",
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
        ),
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.home))],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ForumButton("Forum 1", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 2", () {}),
          ]),
          const SizedBox(
            height: 50.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ForumButton("Forum 3", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 4", () {}),
          ]),
          const SizedBox(
            height: 50.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ForumButton("Forum 5", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 6", () {}),
          ]),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configurações'),
        ],
        selectedItemColor: Colors.black,
        onTap: tapItem,
        currentIndex: itemSelecionado,
      ),
    );
  }
}
