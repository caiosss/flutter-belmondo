import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Models/coment_model.dart';
import 'package:aplicacao_mobile/Models/coment_database_service.dart';

class ComentsList extends StatefulWidget {
  @override
  _ComentsListState createState() => _ComentsListState();
}


class _ComentsListState extends State<ComentsList> {
  late Future<List<ComentModel>> _cometariosListados;

  @override
  void initState(){
    super.initState();
    _cometariosListados = ComentDatabaseService().getComents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Comentarios'),
      ),
      body: FutureBuilder<List<ComentModel>>(
        future: _cometariosListados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum comentario encontrado.'));
          } else {
            final comentarios = snapshot.data!;
            return ListView.builder(
              itemCount: comentarios.length,
              itemBuilder: (context, index) {
                final user = comentarios[index];
                return ListTile(
                  title: Text(user.userName),
                  subtitle: Text(user.content),
                  
                );
              },
            );
          }
        },
      ),
    );
  }
}