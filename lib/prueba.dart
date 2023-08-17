//import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override  
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // URL de la API
  final String apiUrl = 'https://integration.jps.go.cr/api/App/lotto/last';

  // Variable para almacenar los datos obtenidos de la API
  Map apiData = {}; 

  // Función para obtener los datos de la API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, analiza el JSON
      setState(() {
        //decode = 'hola';//json.decode(response.body);
        apiData = json.decode(response.body);
        //apiData = jsonDecode(response.body);
      });
    } else {
      // Si la solicitud falla, maneja el error
      throw Exception('Error al cargar los datos desde la API');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lectura de API JSON en Flutter'),
        ),
        body: Center(
          child: FutureBuilder<Map>(           
            builder: (context, snapshot) {
              return  
              Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: 
                    Column(
                      children: [
                        /*Column(
                          children: [Text(apiData['dia'].toString())],
                        ),*/
                        Column(
                          children: [Text(apiData.toString())],
                        ),
                        /*Column(
                          children: [Text('Mañana: ' + apiData['manana']['numero'].toString())],
                        ),
                        Column(
                          children: [Text('Tarde: ' + apiData['mediaTarde']['numero'].toString())],
                        ),
                        Column(
                          children: [Text('Noche: ' + apiData['tarde']['numero'].toString())],
                        ) */                             
                      ],
                    ),                    
              );
            }
          ),
        ),
      ),
    );
  }
}