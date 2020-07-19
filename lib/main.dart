import 'package:flutter/material.dart';

void main() {
  runApp(TangkapIkanApp());
}

class TangkapIkanApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Nelayan Tangkap Ikan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nelayan Tangkap Ikan'),
        ),
        body: Container(
          child: const Text('Daftar Tangkapan Ikan'),
        ),
      ),
    );
  }
}
