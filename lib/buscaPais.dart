import 'dart:convert';


import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

class BuscaPais extends StatefulWidget { final String nome; final String data; final int mortos; final int casosConfirmados; final int casosRecuperados;
  const BuscaPais({Key key, this.nome, this.data, this.mortos, this.casosConfirmados, this.casosRecuperados});

 @override
  _BuscaPaisState createState() => _BuscaPaisState();
} 

class _BuscaPaisState extends State<BuscaPais> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( appBar: AppBar( leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);
          },),
        ),



        body:  Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              ListTile(title:(Text(widget.nome)),subtitle: Text(widget.data
              ),),


              ListTile(title:Text('Total Confirmado:' +'  '+ widget.casosConfirmados.toString()),leading: Image.asset('images/angry.png'),
              ),

              ListTile(title:Text('Total Recuperado:' +'  '+
                  widget.casosRecuperados.toString()),leading: Image.asset('images/happy.png'),),


              ListTile(title: Text('Total Mortes:' +'  '+ widget.mortos.toString()),
                leading: Image.asset('images/sad.png'),),]),

                
      ),
    );
  }

  
}



