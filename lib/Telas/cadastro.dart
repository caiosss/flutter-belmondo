import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/background_wave_clipper.dart';
import 'package:aplicacao_mobile/Telas/login.dart';
import 'package:aplicacao_mobile/Models/database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';

void main () => runApp(const TelaCadastro());

class TelaCadastroApp extends StatelessWidget{
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
  late String nome;
  late String senha;
  late String email;
  final dbService = DatabaseService(); 



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: ThemeData(primarySwatch: Colors.blueGrey,),
      home: Scaffold(
        body: Container(
     //color: Color.fromARGB(255, 5, 10, 48), 
      child: ListView(
        children: [ClipPath(
          clipper: BackgroundWaveClipper(), // <- inicio da copia
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:
                    300, // <- sugiro que deixe essa altura, mas se houver necessidade pode mudar
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 2, 40, 70)),
              ),
            ),
        ),
          Text("Cadastro",style: TextStyle(fontSize: 37.1, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 10, 48) ),textAlign: TextAlign.center ),
          SizedBox(
            height: 10,
          ),Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Já está registrado?", style: TextStyle(fontSize: 13.2,fontWeight: FontWeight.w300,fontFamily: 'Poppins'),),Builder(builder:(context) => TextButton(child: Text("Logue aqui", style:TextStyle(fontSize: 13.2,fontWeight: FontWeight.w300,fontFamily: 'Poppins')),onPressed:() {Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchPage()));
            
          }, ) ,)]), SizedBox(
            height: 10,
          ),
          /**/
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: 344,
            height: 65,
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (text) {
                nome = text;
              },
              decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
                      ),),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: 344,
            height: 65,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (text){
                email = text;
              },
              decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: 344,
            height: 65,
            child: TextField(
              onChanged: (text){
                senha = text;
              },
              decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              width: 339,
              height: 63,
              child: ElevatedButton(onPressed: () {
                var user;
                if(email.contains("@unifor.com")){//tem que fazer uma verificação melhor de email kkkk
                   user = UserModel(id: "0", name: nome, email: email, password: senha, isAdm: true);
                } else {
                   user = UserModel(id: "0", name: nome, email: email, password: senha, isAdm: false);// falta a logica do id
                }

                dbService.initDatabase(); // Perguntar ao belmondo quando se usa tal proeza ou se não precisa usar
                dbService.insertUser(user);
                Navigator.of(context).pop();
              }, 
              child: const Text("Cadastrar-se",
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
    )));
  }
}

 