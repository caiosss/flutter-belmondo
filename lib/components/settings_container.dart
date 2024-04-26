import 'package:flutter/material.dart';

//container que precisa ser alterado para ajustar as configurações!!

class SetContainer extends StatelessWidget{
    final String text;
    

    SetContainer(this.text);

    @override
    Widget build(BuildContext context){
      return Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                  Text(text, style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,

                  ),)
               ],
        ),
      );
    }

}