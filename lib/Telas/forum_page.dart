import 'package:aplicacao_mobile/Models/coment_database_service.dart';
import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const ForumApp());

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Forum(forumId: 1, userId: 1),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Forum extends StatefulWidget {
  final forumId;
  final userId;

  const Forum({super.key, this.forumId, this.userId});

  @override
  State<Forum> createState() => ForumState();
}

class ForumState extends State<Forum> {
  final double coverHeight = 274;
  final double forumHeight = 144;
  final double forumWidth = 180;
  final TextEditingController contentContoller = TextEditingController();
  final comentDbService = ComentDatabaseService();
  final userDbService = UserDatabaseService();
  String userName = "";
  int comentId = 0;
  
  List<dynamic> comentarios = [];
  
  @override
  void initState() {
    super.initState();
    getUserName();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://belmondojr.dev/consultas_moveis/consulta_iury.php?action=foruns'));
     if (response.statusCode == 200) {
      setState(() {
        comentarios = json.decode(response.body);
      });
    }
  }
  
  Future<void> getUserName() async {
    List<UserModel> usuarios = await userDbService.getUsers();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios.elementAt(i).id == widget.userId) {
        setState(() {
          userName = usuarios.elementAt(i).name;
        });
      }
    }
  }

  Future<void> comentar() async {
    comentId = comentarios.length + 1;
    final response = await http.post(
      Uri.parse('https://belmondojr.dev/consultas_moveis/consulta_iury.php?action=foruns'),
      body: {
        'id': comentId.toString(),
        'forum_id': widget.forumId,
        'content': contentContoller,
        'user_name': userName
      },);
      
      if (response.statusCode == 200) {
      print("deu certo");
    } else {
      print('Erro ao adicionar o usuário: ${response.statusCode}');
    }
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

  Widget buildCommentSectiom() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: comentarios.length,
        itemBuilder: (context, index) {
          final comentario = comentarios[index];
          if(comentario['forum_id'] == widget.forumId){
              return ListTile(
              title: Text('${comentario['user_name']}'),
              subtitle: Text('CPF: ${comentario['content']}'),
              trailing: comentario['user_name'] == userName ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            comentDbService.deleteComent(comentarios[index].id);
                            setState(() {});
                          },
                        )
                      : null,
                   
            );
          } else {
            return Container();
          }
          
        },
      );
      
  }

  Widget buildContent() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Teste123",
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
              children: [buildCommentSectiom()],
            ),
            const SizedBox(height: 20), 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(children: [
                    TextField(
                    decoration: InputDecoration(
                      labelText: "Comentario",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    controller: contentContoller,
                    
                  ),
                  ElevatedButton(onPressed: comentar, child: Text("Comentar"))
                  ],)
                ),
              ],
            ),
          ],
        ),
      );
}
