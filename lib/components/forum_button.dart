import 'package:flutter/material.dart';

class ForumButton extends StatelessWidget {
  final String texto;
  final void Function() funcaoChamada;
  final String? imagemURL;

  ForumButton(this.texto, this.funcaoChamada, this.imagemURL);
  ForumButton.semImagem(this.texto,this.funcaoChamada):imagemURL=null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
       decoration: imagemURL != null
          ? BoxDecoration(image: DecorationImage(image: NetworkImage(imagemURL!),fit: BoxFit.cover))
          : null,
      child: ElevatedButton(
        onPressed: funcaoChamada,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: imagemURL != null ? Colors.transparent : Colors.grey,
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: imagemURL != null ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
