import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const ComentsListApp());

class ComentsListApp extends StatelessWidget {
  const ComentsListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comentarios',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ComentsList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ComentsList extends StatefulWidget {
  const ComentsList({Key? key}) : super(key: key);

  @override
  _ComentsListState createState() => _ComentsListState();
}

class _ComentsListState extends State<ComentsList> {
  List<dynamic> comentarios = [];
  bool isLoading = true;
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://belmondojr.dev/consultas_moveis/consulta_iury.php?action=foruns'),
      );
      if (response.statusCode == 200) {
        setState(() {
          comentarios = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar comentários');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro: $e');
    }
  }

  Future<void> comentar() async {
    var id = comentarios.length + 1;
    final response = await http.post(
      Uri.parse('https://belmondojr.dev/consultas_moveis/consulta_iury.php?action=foruns'),
      body: {
        'id': id.toString(),
        'forum_id': '1', // Certifique-se de usar o ID correto do fórum
        'content': contentController.text,
        'user_name': 'iury', // Substitua pelo nome de usuário correto
      },
    );

    if (response.statusCode == 200) {
      print("Comentário adicionado com sucesso");
      contentController.clear();
      fetchData(); // Recarrega os dados após adicionar um comentário
    } else {
      print('Erro ao adicionar o comentário: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Comentarios'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comentarios.length,
                    itemBuilder: (context, index) {
                      final comentario = comentarios[index];
                      return ListTile(
                        title: Text('${comentario['user_name']}'),
                        subtitle: Text('${comentario['content']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Função de deletar comentário (a ser implementada)
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Comentario",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    controller: contentController,
                  ),
                ),
                ElevatedButton(
                  onPressed: comentar,
                  child: Text("Comentar"),
                ),
              ],
            ),
    );
  }
}
