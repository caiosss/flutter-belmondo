import 'package:aplicacao_mobile/Telas/tela_usuarios_teste.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/background_wave_clipper.dart';
import 'package:aplicacao_mobile/Telas/login.dart';
import 'package:aplicacao_mobile/Models/database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';
import 'package:aplicacao_mobile/components/dialog_box.dart';
import 'package:aplicacao_mobile/components/edit_dialog_box.dart';


void main() => runApp(const TelaCadastroApp());

class TelaCadastroApp extends StatelessWidget {
  const TelaCadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaCadastro(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  String nome = '';
  String senha = '';
  String email = '';
  final dbService = DatabaseService(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 2, 40, 70)),
                ),
              ),
            ),
            Text("Cadastro", style: TextStyle(fontSize: 37.1, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 10, 48)), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Já está registrado?", style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
              Builder(
                builder: (context) => TextButton(
                  child: Text("Logue aqui", style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
              ),
            ]),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: 344,
              height: 65,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {
                    nome = text;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  )
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: 344,
              height: 65,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  setState(() {
                    email = text;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  )
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              width: 344,
              height: 65,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    senha = text;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  )
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              width: 339,
              height: 63,
              child: ElevatedButton(
                onPressed: () async {
                  var user;
                  var id;
                  Future<List<UserModel>> usersFuture = dbService.getUsers();
                  List<UserModel> users = await usersFuture;
                  id = users.length + 1;
                  if (senha.length < 8) {
                    showDialog(
                      context: context,
                      builder: (context) => DialogBox("A senha precisa ter mais de 8 caracteres!")
                    );
                  } else if (!email.contains("@")) {
                    showDialog(
                      context: context,
                      builder: (context) => DialogBox("Insira um email válido!")
                    );
                  }
                   else if(await dbService.emailExists(email)){
                    showDialog(
                    context: context,
                    builder: (context) => DialogBox("Esse email já está registrado!"),
                    );
                   }
                   else {
                    user = UserModel(
                      id: id.toString(),
                      name: nome,
                      email: email,
                      password: senha,
                      isAdm: email.contains("@unifor.br") ? true : false
                    );
                    dbService.insertUser(user);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  "Cadastrar-se",
                  style: TextStyle(
                    fontSize: 26.1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  backgroundColor: const Color.fromARGB(255, 2, 40, 70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}