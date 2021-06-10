import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'buscaPais.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController search =TextEditingController();
  Future<Map> _getdata() async {

    http.Response response;

    response = await http.get('https://api.covid19api.com/summary');
    return jsonDecode(response.body);
  }

  @override
  void initState() {

    super.initState();

    _getdata().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dados Mundiais do Covid'),
        ),
        body: Column(
          children: [

            Container(
              child: FutureBuilder(

                future: _getdata(),

                builder: (context, snapshot) {

                  switch (snapshot.connectionState) {

                    case ConnectionState.waiting:

                    case ConnectionState.none:

                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );


                    default:

                      if (snapshot.hasError)

                        return Container();

                      else
                        return _global(context, snapshot);
                  }
                },
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Container(child: TextField(

                decoration: InputDecoration(prefixIcon:Icon( Icons.search),
                  labelText: 'Pesquisa',

                ),
                controller:search,
              ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 3,
                  ),
                ),),
            ),
            SizedBox(height: 30),
            Expanded(

              child: FutureBuilder(

                future: _getdata(),

                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(

                        child: Center(child: CircularProgressIndicator(),),

                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _datas(context, snapshot);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _datas(BuildContext context, AsyncSnapshot snapshot) {
  
  return ListView.builder(itemBuilder: (context, index) {

    return ListTile(
      title: 

      Text(snapshot.data['Countries'][index]['Country']+' - '+ snapshot.data['Countries'][index]['CountryCode']),
      subtitle:

      Text(snapshot.data['Countries'][index]['Date'].toString()),
      onTap: (){

        print( snapshot.data['Countries'][index]['Country']);
        Navigator.push(context,  MaterialPageRoute(builder: (context) => BuscaPais(nome: snapshot.data['Countries'][index]['Country'],data: snapshot.data['Countries'][index]['Date'],casosConfirmados: snapshot.data['Countries'][index]['TotalConfirmed'],casosRecuperados: snapshot.data['Countries'][index]['TotalRecovered'],mortos: snapshot.data['Countries'][index]['TotalDeaths'],)));
      },
    );
  });
}

Widget _global(BuildContext contex, AsyncSnapshot snapshot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [

      ListTile(title: Text('Dados Globais:'),subtitle: Text(snapshot.data['Global']['Date'].toString()
      ),),


      ListTile(title: Text('Total Confirmado:' +'  '+
          snapshot.data['Global']['TotalConfirmed'].toString(),),leading: Image.asset('images/angry.png'),),


      ListTile(title:  Text('Total Recuperado:' +'  '+
          snapshot.data['Global']['TotalRecovered'].toString()),leading: Image.asset('images/happy.png'),),
      ListTile(title: Text('Total Mortes:' +'  '+ snapshot.data['Global']['TotalDeaths'].toString(),),leading: Image.asset('images/sad.png'),)



    ],
  );
}
