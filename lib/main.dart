import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';

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

// data awal yang akan ditampilan sebagai daftar tangkapan ikan
// daftar ini kemudian akan bisa ditambahkan tangkapan ikan oleh pengguna

var tangkapanIkanList = [
  TangkapanIkan(
    tanggal: '2020-07-03',
    tangkapan: [
      {
        'jenis': Ikan(nama: 'Baronang', gambarAset: 'images/baronang.jpg'),
        'jumlah': 11,
      },
      {
        'jenis': Ikan(nama: 'Kerapu', gambarAset: 'images/kerapu.jpg'),
        'jumlah': 10,
      }
    ],
  ),
  TangkapanIkan(
    tanggal: '2020-07-04',
    tangkapan: [
      {
        'jenis':
            Ikan(nama: 'Kakap Merah', gambarAset: 'images/kakap-merah.jpg'),
        'jumlah': 12,
      },
    ],
  ),
  TangkapanIkan(
    tanggal: '2020-07-05',
    tangkapan: [],
  ),
  TangkapanIkan(
    tanggal: '2020-07-06',
    tangkapan: [
      {
        'jenis': Ikan(nama: 'Cumi', gambarAset: 'images/cumi.jpg'),
        'jumlah': 12,
      },
      {
        'jenis': Ikan(nama: 'Udang', gambarAset: 'images/udang.jpg'),
        'jumlah': 11,
      },
      {
        'jenis': Ikan(nama: 'Kepiting', gambarAset: 'images/kepiting.jpg'),
        'jumlah': 10,
      },
    ],
  ),
];
