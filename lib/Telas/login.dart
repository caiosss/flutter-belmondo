import 'package:aplicacao_mobile/Telas/home_page_qrcode.dart';
import 'package:aplicacao_mobile/Telas/settings.dart';
import 'package:aplicacao_mobile/Telas/cadastro.dart';
import 'package:aplicacao_mobile/Telas/home_page.dart';
import 'package:aplicacao_mobile/components/background_wave_clipper.dart';
import 'package:aplicacao_mobile/components/dialog_box.dart';
import 'package:aplicacao_mobile/components/edit_dialog_box.dart';
import 'package:aplicacao_mobile/data/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SearchPage(),
        debugShowCheckedModeBanner: false);
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final dbService = UserDatabaseService();
  String email = "";
  String password = "";

  void toHomePage() async {
    if (!email.contains('@') || password.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => DialogBox("Formato Email ou Senha inválido!"));
    } else {
      Future<List<UserModel>> usersFuture = dbService.getUsers();
      List<UserModel> users = await usersFuture;
      bool found = false;
      int index = 0;
      for (int i = 0; i < users.length; i++) {
        if (users.elementAt(i).email == email) {
          found = true;
          index = i;
        }
      }
      if (found) {
        if (users.elementAt(index).email == email &&
            users.elementAt(index).password == password) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userId: users.elementAt(index).id)));
        } else {
          showDialog(
              context: context,
              builder: (context) => DialogBox("Email ou Senha inválido!"));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => DialogBox("Usuário não encontrado"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: BackgroundWaveClipper(),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 2, 40, 70)),
              ),
            ),
          ),
          const Text(
            "Login",
            style: TextStyle(
                fontSize: 37.1,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 14),
          const Text(
            "Logue para continuar",
            style: TextStyle(
                fontSize: 13.2, fontWeight: FontWeight.w300, fontFamily: "Poppins"),
          ),
          const SizedBox(height: 55),
          Container(
            width: 344,
            height: 65,
            child: TextField(
              decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
              onChanged: (text) {
                setState(() {
                  email = text;
                });
              },
            ),
          ),
          const SizedBox(height: 55),
          Container(
            width: 344,
            height: 65,
            child: TextField(
              decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
              onChanged: (text) {
                setState(() {
                  password = text;
                });
              },
              obscureText: true,
            ),
          ),
          const SizedBox(height: 38),
          Container(
            width: 339,
            height: 63,
            child: ElevatedButton(
              onPressed: toHomePage,
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
          const SizedBox(height: 65),
          Builder(
            builder: (context) => TextButton(
              child: const Text("Esqueceu a senha?",
                  style: TextStyle(
                      fontSize: 13.2,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins')),
              onPressed: () {
                // Handle forgot password
              },
            ),
          ),
          const SizedBox(height: 5),
          Builder(
            builder: (context) => TextButton(
              child: const Text("Cadastre-se!",
                  style: TextStyle(
                      fontSize: 13.2,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins')),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaCadastro()));
              },
            ),
          ),
        ],
      ),
    );
  }
}