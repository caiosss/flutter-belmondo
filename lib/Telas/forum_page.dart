import 'package:aplicacao_mobile/Models/coment_database_service.dart';
import 'package:aplicacao_mobile/Models/user_database_service.dart';
import 'package:aplicacao_mobile/Models/coment_model.dart';
import 'package:aplicacao_mobile/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const ForumApp());

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Forum(),
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
  String comentario = "";
  final comentDbService = ComentDatabaseService();
  final userDbService = UserDatabaseService();
  String userName = "";

  
  void teste() {
    print("teste123");
  }

  @override
  void initState(){
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
      List<UserModel> usuarios = await userDbService.getUsers();
      for(int i = 0; i < usuarios.length; i++){
          if(usuarios.elementAt(i).id == widget.userId){
            userName = usuarios.elementAt(i).name;
          }
      }
  }

  Future<void> comentar(String comentario) async {
      if(comentario.isEmpty){
        return;
      } else {
        var id;
        List<ComentModel> comentarios = await comentDbService.getComents();
        id = comentarios.length + 1;
        var coment = ComentModel(forumId: widget.forumId, content: comentario, userName: userName, id: id.toString());
        await comentDbService.insertComent(coment);
      }
  }

  void controleOnsubmit(comentario){
    comentar(comentario).then((_) {
      comentario = "";
    });
  }
  

  int itemSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        buildTop(),
        buildContent(),
      ],
    ));
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
              children: [
                Text(
                  "O Fórum tal possui...",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 430,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Digite..",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                    onChanged: (text) {
                        comentario = text;
                    },

                    onSubmitted: controleOnsubmit,
                   
                  
                    
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
