import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';

// Utama atau Laman, artinya halaman utama (HomeScreen)
// merupakan Stateful Widget karena nanti ada pengubahan state tangkapanIkanList

class UtamaScreen extends StatefulWidget {
  final List<TangkapanIkan> tangkapanIkanList;

  UtamaScreen({Key key, this.tangkapanIkanList}) : super(key: key);

  @override
  _UtamaScreenState createState() => _UtamaScreenState();
}

class _UtamaScreenState extends State<UtamaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nelayan Tangkap Ikan'),
      ),
      body: ListView(
        children: widget.tangkapanIkanList
            .where((tangkapanIkan) => tangkapanIkan.tangkapan.length > 0)
            .map((tangkapanIkan) {
          String gambarAset = '';
          String teksDaftar = '';
          int jumlahTampil = 2; // menampilkan maksimum 2 di daftar

          // iterasi seluruh data tangkapan, data minimal 1 tangkapan
          int jumlahTerbanyak = 0;
          tangkapanIkan.tangkapan.asMap().forEach((idx, tangkapan) {
            Ikan ikan = tangkapan['jenis'];
            int jumlah = tangkapan['jumlah'];
            if (gambarAset == '') gambarAset = ikan.gambarAset; // inisialisasi
            if (jumlah > jumlahTerbanyak) {
              // tampilkan 1 gambar dari tangkapan dengan jumlah terbanyak
              jumlahTerbanyak = jumlah;
              gambarAset = ikan.gambarAset;
            }
            if (idx < jumlahTampil) {
              if (idx > 0) teksDaftar += ' '; // spasi antar kalimat
              teksDaftar += '${ikan.nama}: $jumlah ekor.';
            } else if (idx == jumlahTampil) {
              teksDaftar += '..'; // dst
            }
          });

          // isi dari ListView
          return FlatButton(
            onPressed: () {},
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(gambarAset),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Tangkapan tanggal: ${tangkapanIkan.tanggal}',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            teksDaftar,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Tambah Tangkapan Ikan',
        onPressed: () {},
      ),
    );
  }
}
