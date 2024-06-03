import 'package:aplicacao_mobile/Telas/settings.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/components/forum_button.dart';
import 'package:aplicacao_mobile/Telas/login.dart';
import 'package:aplicacao_mobile/Telas/perfil.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(const HomePageApp());

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(userId: '',),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final userId;

  const HomePage({super.key, required this.userId, });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int itemSelecionado = 1;
  String ticket = "";
   
  void tapItem(int index){
    
    setState((){
        itemSelecionado = index;
        if(itemSelecionado == 0){
          toProfile();
        }
        if(itemSelecionado == 2){
          toSettingsPage();
        }
    });
  }


  void toLoginPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
  }

  void toProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userId: widget.userId)));
  }

  void toSettingsPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(userId: widget.userId)));
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
  }

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
            ForumButton("Forum 1", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 2", () {}),
          ]),
          const SizedBox(
            height: 50.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ForumButton("Forum 3", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 4", () {}),
          ]),
          const SizedBox(
            height: 50.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ForumButton("Forum 5", () {}),
            const SizedBox(
              width: 33.0,
            ),
            ForumButton("Forum 6", () {}),
          ]),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 2, 40, 70),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil',),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações',),
        ],
        selectedItemColor: Colors.white,
        onTap: tapItem,
        currentIndex: itemSelecionado,

      ),
    );
  }
}
