import 'dart:async';
//import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      //.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
.get(Uri.parse('https://integration.jps.go.cr/api/App/nuevostiempos/last'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Inconvenientes para consultar la información');
  }
}


class Album {
  final String dia;  
  final String numeroManana;
  final String numeroTarde;
  final String numeroNoche;
  final String numeroSorteo;
  
  const Album({
    required this.dia,
    required this.numeroManana,
    required this.numeroTarde,
    required this.numeroNoche,
    required this.numeroSorteo
  });

  factory Album.fromJson(Map<String, dynamic> json) {   

    var _numeroManana = '';
    var _numeroTarde = '';
    var _numeroNoche = '';

    json.forEach((k,v) {   

      if(v != null && k == 'manana'){ 
        _numeroManana = json['manana']['numero'].toString();     
      }
      else{
        _numeroManana = '--';     
      }
      
      if(v != null && k == 'mediaTarde') 
        _numeroTarde = json['mediaTarde']['numero'].toString(); 
      else _numeroTarde = '--';

      if(v != null && k == 'tarde') 
        _numeroNoche = json['tarde']['numero'].toString(); 
      else  _numeroNoche = '--'; 

    });  

    return Album(
      dia: json['dia'],  
      numeroManana: _numeroManana,   
      numeroTarde: _numeroTarde, 
      numeroNoche: _numeroNoche,
      numeroSorteo: json['manana']['numeroSorteo'].toString()
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'Tiempos JPS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,      
      home: Scaffold(        
        appBar: AppBar(
          title: const Text('JPS'),
        ),                
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var numeroManana = snapshot.data!.numeroManana;
                var numeroTarde = snapshot.data!.numeroTarde;
                var numeroNoche = snapshot.data!.numeroNoche;
                //var numeroSorteo = snapshot.data!.numeroSorteo;
                //return Text(snapshot.data!.dia);                
                return                 
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        //Column(
                          //children: [
                              //Image(image: AssetImage('assets/images/Logo_Nuevos_Tiempos_Reventados.png'))
                              //]                   
                        //),
                        
                        //Column(
                          //children: [
                              //Text('Sorteo número: ' + numeroSorteo,
                                //style: TextStyle(
                                                //fontSize: 25, 
                                                //fontWeight:FontWeight.bold,
                                                //color: Colors.blue
                                                //)
                                //)
                          //]
                        //),

                        Row(
                          children: [
                              Text('Mañana: ' + numeroManana, 
                                style: TextStyle(
                                                fontSize: 25, 
                                                fontWeight:FontWeight.bold,
                                                color: Colors.blue
                                                )
                                )
                          ]
                        ),

                        Row(
                          children: [
                              Text('Tarde: ' + numeroTarde, 
                                style: TextStyle(
                                                fontSize: 25, 
                                                fontWeight:FontWeight.bold,
                                                color: Colors.blue
                                                )
                                )
                          ]
                        ),

                        Row(
                          children: [
                              Text('Noche: ' + numeroNoche, 
                                style: TextStyle(
                                                fontSize: 25, 
                                                fontWeight:FontWeight.bold,
                                                color: Colors.blue
                                                )
                                )
                          ]
                        )
                      
                      ]
                    ),
                  );            
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },                        
          ),
          
        ),
        
      ),
      
    );
  }
  
  
}