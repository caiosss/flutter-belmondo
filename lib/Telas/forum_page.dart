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
      home: Forum(forumId: 1, userId: 1),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Forum extends StatefulWidget {
  final forumId;
  final userId;
  //final imgLink;
  const Forum({super.key, this.forumId, this.userId,}); // receber a imagem a ser carregada via parametro
  //const Forum({super.key, this.forumId, this.userId, this.imgLink}); recebendo a imagem a ser carregada via parametro

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

  //Falta achar Local onde a imagem será exibida
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
        comentDbService.insertComent(coment);
        setState(() {});
      }
  }

  void controleOnsubmit(comentario){
    comentar(comentario).then((_) {
      this.comentario = "";
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

  Widget buildCommentSectiom() {
    return FutureBuilder<List<ComentModel>>(
      future: comentDbService.getComents(), 
      builder: (context, snapshot){
         if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar comentários'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum comentário nesse Forum'));
        } else {
          List<ComentModel> comentarios = snapshot.data!;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comentarios.length,
            itemBuilder:(context, index) {
              if(comentarios[index].forumId == widget.forumId){
                return ListTile(
                title: Text(comentarios[index].userName),
                subtitle: Text(comentarios[index].content),
                trailing: comentarios[index].userName == userName // isso é um botão de delete no comentario e somente o dono pode apagar ele por isso a comparação
                 ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    comentDbService.deleteComent(comentarios[index].id);
                    setState(() {});
                  },
                ) : null
              );
              }
            });
        } 
      });

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
              children: [
                buildCommentSectiom()
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
