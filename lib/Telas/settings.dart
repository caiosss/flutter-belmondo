import 'package:aplicacao_mobile/components/icone_botao.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/information_container.dart';
import 'package:aplicacao_mobile/components/settings_container.dart';
import 'package:aplicacao_mobile/Telas/home_page.dart';

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
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  void toHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>(BottomNavigationBarExample())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape:const  RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 130,
        backgroundColor: const Color.fromARGB(255, 2, 40, 70),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: toHomePage,
          style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white)),
        ),
        title: const Text(
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
                  backgroundColor: Colors.lightBlue[100],
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 2, 40, 70),
              ),
              const Text(
                "Nome",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              const Text("melhorapp@jafeito.com"),
              const SizedBox(
                height: 32.0,
              ),
              InfoContainer("  Geral"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("  Notificações", IconeBotao(const Icon(Icons.notifications),() {},)),
              SetContainer("  Editar perfil", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {},)),
              const SizedBox(
                height: 12.0,
              ),
              InfoContainer("  Acessibilidade"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("  Ativar", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {},)),
              const SizedBox(
                height: 12.0,
              ),
              InfoContainer("  Ajuda"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("  Contato", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {},)),
              SetContainer("  FAQ", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {},)),
            ],
          ),
        ),
      ),
    );
  }
}
