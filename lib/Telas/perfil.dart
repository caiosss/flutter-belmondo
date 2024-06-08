import 'dart:ui';
import 'package:aplicacao_mobile/Models/user_database_service.dart'; 
import 'package:aplicacao_mobile/Models/user_model.dart'; 
import 'package:aplicacao_mobile/Telas/home_page.dart';
import 'package:aplicacao_mobile/Telas/home_page_qrcode.dart';
import 'package:aplicacao_mobile/Telas/settings.dart';
import 'package:aplicacao_mobile/components/edit_dialog_box.dart';
import 'package:aplicacao_mobile/components/forum_button.dart';
import 'package:aplicacao_mobile/components/icone_botao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Profile(userId: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Profile extends StatefulWidget {
  final String userId;

  const Profile({super.key, required this.userId});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final double coverHeight = 274;
  final double profileHeight = 144;
  String name = "";  
  String id = "";  
  String email = ""; 
  String senha = ""; 
  bool adm = false;
  int itemSelecionado = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final dbService = UserDatabaseService();
    List<UserModel> users = await dbService.getUsers();
    for (var user in users) {
      if (user.id == widget.userId) {
        setState(() {
          name = user.name;
          id = user.id;
          email =user.email;
          senha = user.password;
          adm = user.isAdm;
        });
        break;
      }
    }
  }

  

  void tapItem(int index) {
    setState(() {
      itemSelecionado = index;
      if (itemSelecionado == 1) {
        toHomePage();
      } else if (itemSelecionado == 2) {
        toSettingsPage();
      }
    });
  }

  void toSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings(userId: widget.userId))
    );
  }

  void toHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId,))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 2, 40, 70),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        selectedItemColor: Colors.white,
        onTap: tapItem,
        currentIndex: itemSelecionado,
      ),
    );
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
          top: coverHeight - 180 / 2,
          child: buildAvatar(),
        ),
      ],
    );
  }

  Widget buildContent() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,  // Exibe o nome do usuário
              style: const TextStyle(
                fontSize: 38,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            IconeBotao(const Icon(Icons.edit), () {
               showDialog(
                context: context, 
               builder: (context) => EditarDadoDialog("nome", name, email, senha, adm, id));
            })
          ],
        ),
        const SizedBox(height: 38),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Forúns: ",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            ForumButton("Forum 1", () {}),
            const SizedBox(width: 27),
            ForumButton("Forum 2", () {}),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            ForumButton("Forum 3", () {}),
            const SizedBox(width: 27),
            ForumButton("Forum 4", () {}),
          ],
        ),
      ],
    ),
  );

  Widget buildCover() => Container(
    color: Color.fromARGB(255, 2, 40, 70),
    height: coverHeight,
  );

  Widget buildAvatar() => CircleAvatar(
    radius: 90,
    backgroundColor: Color.fromARGB(255, 4, 112, 194),
    child: CircleAvatar(
      radius: 86,
      backgroundColor: Colors.lightBlue[100],
      child: const Icon(
        Icons.person,
        size: 120,
        color: Colors.black,
      ),
    ),
  );
}
