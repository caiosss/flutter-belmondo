import 'dart:ui';

import 'package:aplicacao_mobile/components/background_wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bunny Search SearchBar Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SearchPage(),
        debugShowCheckedModeBanner: false);
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath( // <- esse é o responsável por chamar o component wave_clipper
            clipper: BackgroundWaveClipper(), // <- inicio da copia
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300, // <- sugiro que deixe essa altura, mas se houver necessidade pode mudar
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 2, 40, 70)),
              ),
            ),
          ), // <- fim da copia
          Container(
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 37.1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            child: const Text(
              "Logue para continuar",
              style: TextStyle(
                  fontSize: 13.2,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(
            height: 55,
          ),
          Container(
            width: 344,
            height: 65,
            child: const TextField(
                decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))))),
          ),
          const SizedBox(
            height: 55,
          ),
          Container(
            width: 344,
            height: 65,
            child: const TextField(
                decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))))),
          ),
          const SizedBox(
            height: 38,
          ),
          Container(
            width: 339,
            height: 63,
            child: ElevatedButton(
              onPressed: () {
                print("funciona");
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 26.1,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                backgroundColor: const Color.fromARGB(255, 2, 40, 70),
              ),
            ),
          ),
          const SizedBox(
            height: 65,
          ),
          Container(
            child: const Text(
              "Esqueceu a senha?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            child: const Text(
              "Cadastre-se!",
              style: TextStyle(
                  fontSize: 14.8,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins"),
            ),
          ),
        ],
      ),
    );
  }
}

