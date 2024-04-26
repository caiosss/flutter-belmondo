import 'package:flutter/material.dart';

//container apenas de informações
class InfoContainer extends StatelessWidget{
    final String text;
    

    InfoContainer(this.text);

    @override
    Widget build(BuildContext context){
      return Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
        child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                  Text(text, style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,

                  ),)
               ],
        ),
      );
    }

}