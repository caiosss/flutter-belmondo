import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';
import 'package:aplicacao_mobile/Telas/home_page_qrcode.dart';
import 'package:aplicacao_mobile/components/icone_botao.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/information_container.dart';
import 'package:aplicacao_mobile/components/settings_container.dart';
import 'package:aplicacao_mobile/components/switch_container.dart';
import 'package:aplicacao_mobile/Telas/home_page.dart';
import 'package:aplicacao_mobile/components/dialog_box.dart';
import 'package:aplicacao_mobile/components/edit_dialog.dart';


void main() => runApp(const SettingsApp());

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Settings(userId: '',),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Settings extends StatefulWidget {
  final String userId;

  const Settings({super.key, required this.userId});

  @override
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
   String name = '';
   String email = '';
   String password = '';
   String id = '';
   bool isAdm = false;
   bool _isSwitchedNotification = false;
   bool _isSwitchedAcessibilty = false;


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
      final dbService = UserDatabaseService();
      List<UserModel> users = await dbService.getUsers();
      for(var user in users){
        if(user.id == widget.userId){
          setState(() {
            name = user.name;
            email = user.email;
            password = user.password;
            isAdm = user.isAdm;
            id = user.id;
          });
          break;
        }
      }
  }

  void toHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>(HomePage(userId: widget.userId))));
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => EditDialog(name, email, password, isAdm, id),
    );
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
               Text(
                name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(email),
              const SizedBox(
                height: 32.0,
              ),
              InfoContainer("  Geral"),
              const SizedBox(
                height: 12.0,
              ),
              SwitchContainer("  Notificações", 
                Switch(
                  value: _isSwitchedNotification, 
                  onChanged: (value){
                    setState(() {
                      _isSwitchedNotification = value;
                    });
                  },)),
              SizedBox(height: 12,),
              SetContainer("  Editar perfil", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),_showEditDialog,)),
              const SizedBox(
                height: 12.0,
              ),
              SwitchContainer("  Acessibilidade", Switch(
                  value: _isSwitchedAcessibilty, 
                  onChanged: (value){
                    setState(() {
                      _isSwitchedAcessibilty
                       = value;
                    });
                  },)),
              const SizedBox(
                height: 12.0,
              ),
              const SizedBox(
                height: 12.0,
              ),
              InfoContainer("  Ajuda"),
              const SizedBox(
                height: 12.0,
              ),
              SetContainer("  Contato", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {
                showDialog(
                  context: context,
                  builder: (context) => DialogBox("Entre em contato com o suporte:\n +55 85 9 77777777"));
              },)),
              SetContainer("  FAQ", IconeBotao(const Icon(Icons.arrow_forward_ios_rounded),() {},)),
            ],
          ),
        ),
      ),
    );
  }
}
