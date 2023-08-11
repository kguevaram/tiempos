import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String numero;
  
  const Album({
    required this.dia,
    required this.numero
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      dia: json['dia'],
      numero: json['manana.numero']      
    );
  }
}

void main() => runApp(const MyApp());

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
      home: Scaffold(        
        appBar: AppBar(
          title: const Text('Tiempos JPS'),
        ),
        body: Center(          
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var numero = snapshot.data!.numero;
                //return Text(snapshot.data!.dia);
                return Text(numero);
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