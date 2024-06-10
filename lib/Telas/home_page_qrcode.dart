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
              }),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 2", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 2, userId: widget.userId,)));// Falta a imagem do forum
              }),
            const SizedBox(
              height: 50.0,
            ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ForumButton("Forum 3", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 3, userId: widget.userId,)));// Falta a imagem do forum
              }),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 4", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 4, userId: widget.userId,)));// Falta a imagem do forum
              }),
            const SizedBox(
              height: 50.0,
            ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ForumButton("Forum 5", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 5, userId: widget.userId,)));// Falta a imagem do forum
              }),
              const SizedBox(
                width: 33.0,
              ),
              ForumButton("Forum 6", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forum(forumId: 6, userId: widget.userId,)));// Falta a imagem do forum
              }),
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
