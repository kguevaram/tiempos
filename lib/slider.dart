import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget de Imágenes en Flutter con Slider'),
        ),
        body: ImageSlider(), // Utilizamos nuestro widget personalizado
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imageUrls = [
    'https://media.istockphoto.com/id/1405583619/es/foto/met%C3%A1fora-del-trabajo-en-equipo-en-los-negocios.jpg?s=1024x1024&w=is&k=20&c=OmbJpEEJ5jHgCnNA4_dPelvBLUZNhIUz40BlsiEDq5E=',    
    // Agrega más URLs de imágenes según tus necesidades
  ];

  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(imageUrls[_sliderValue.toInt()]),
        ),
        Slider(
          value: _sliderValue,
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
            });
          },
          max: imageUrls.length - 1.toDouble(),
          min: 0,
        ),
      ],
    );
  }
}