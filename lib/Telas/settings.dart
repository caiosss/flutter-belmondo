import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/information_container.dart';
import 'package:aplicacao_mobile/components/settings_container.dart';

void main() => runApp(const SettingsApp());

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Settings(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() =>
      SettingsState();
}

class SettingsState extends State<Settings> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 130,
        backgroundColor: const Color.fromARGB(255, 5, 92, 133),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {},),
        title: Text(
          "Settings", 
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 26.1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 54,
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 70, color: Colors.black,), backgroundColor: Colors.lightBlue[100], ), 
                  backgroundColor: const Color.fromARGB(255, 5, 92, 133),), 
              Text(
                "Nome",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, 
                ),
                ),
              Text("melhorapp@jafeito.com"),
              InfoContainer("Geral"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("Notificações"),
              SetContainer("Editar perfil"),
              const SizedBox(
                height: 12.0,
              ),
              InfoContainer("Acessibilidade"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("Ativar"),
              const SizedBox(
                height: 12.0,
              ),
              InfoContainer("Ajuda"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("Contato"),
              SetContainer("FAQ"),

            ],),
          ),
        ),
    );
  }

}