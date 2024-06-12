import 'package:aplicacao_mobile/Telas/forum_page.dart';
import 'package:aplicacao_mobile/Telas/settings.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/forum_button.dart';
import 'package:aplicacao_mobile/Telas/login.dart';
import 'package:aplicacao_mobile/Telas/perfil.dart';
import 'package:aplicacao_mobile/Telas/presenca.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(const HomePageApp());

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(
        userId: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final userId;

  const HomePage({
    super.key,
    required this.userId,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int itemSelecionado = 1;
  String ticket = "";
  List<ForumButton> foruns = List.empty();
  
  

  void tapItem(int index) {
    setState(() {
      itemSelecionado = index;
      if (itemSelecionado == 0) {
        toProfile();
      }
      if (itemSelecionado == 2) {
        toSettingsPage();
      }
    });
  }

  void toLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  void toProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(userId: widget.userId)));
  }

  void toSettingsPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Settings(userId: widget.userId)));
  }

  

  readQrCode() async {
    print("entrou");
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != "-1" ? code : "Não validado");

    Map<String, Widget Function(BuildContext)> routes = {
      "home": (context) => HomePage(userId: widget.userId),
      "config": (context) => Settings(userId: widget.userId),
      "Presença": (context) => PresencePage(userId: widget.userId),
      "Presenca": (context) => PresencePage(userId: widget.userId),
      "presenca": (context) => PresencePage(userId: widget.userId),
      "presença": (context) => PresencePage(userId: widget.userId),
      "https://www.google.com/" : (context) => PresencePage(userId: widget.userId),
      "https://www.google.com" : (context) => PresencePage(userId: widget.userId),
      "www.google.com" : (context) => PresencePage(userId: widget.userId),
    };

    if (routes.containsKey(ticket)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => routes[ticket]!(context)),
      );
    } else {
      // Handle case where QR code value does not match any route
      print("QR code não corresponde a nenhuma rota.");
    }
  }

  

//   Widget imprimirForuns(List<ForumButton> foruns) {
//   return Column(
//     children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             foruns.elementAt(1),
//             const SizedBox(width: 33.0),
//             if (1 + 1 < foruns.length) foruns.elementAt(1 + 1),
//           ],
//         ),
//         const SizedBox(height: 50.0),
//        for (int i = 0; i < foruns.length; i += 2) {
//        },
//     ],
//   );
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 130,
        backgroundColor: Color.fromARGB(255, 2, 40, 70),
        leading: const Icon(Icons.person),
        title: const SearchBar(
          keyboardType: TextInputType.text,
          hintText: "Pesquise aqui",
          padding: MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: readQrCode,
            style: const ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
          )
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ForumButton("Forum 1", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 1, userId: widget.userId,)));// Falta a imagem do forum
              },"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1200px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg"),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 2", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 2, userId: widget.userId,)));// Falta a imagem do forum
              },"data:image/jpeg;base64,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"),
            const SizedBox(
              height: 50.0,
            ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ForumButton("Forum 3", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 3, userId: widget.userId,)));// Falta a imagem do forum
              },"data:image/jpeg;base64,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"),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 4", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 4, userId: widget.userId,)));// Falta a imagem do forum
              },"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1200px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg"),
            const SizedBox(
              height: 50.0,
            ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ForumButton("Forum 5", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 5, userId: widget.userId,)));// Falta a imagem do forum
              },"data:image/jpeg;base64,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"),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 6", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 6, userId: widget.userId,)));// Falta a imagem do forum
              },"data:image/jpeg;base64,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"),
            ]),
        ],
      )),
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
}
