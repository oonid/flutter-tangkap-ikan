import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';

// halaman detail dari tangkapan ikan pada suatu hari/tanggal
// merupakan Stateless Widget karena tidak ada perubahan dari data detail

class DetailTangkapanIkanScreen extends StatelessWidget {
  final TangkapanIkan tangkapanIkan;

  DetailTangkapanIkanScreen(this.tangkapanIkan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tangkapan Ikan',
            style: TextStyle(
                fontFamily: 'Lobster_Two',
                fontStyle: FontStyle.italic,
                fontSize: 30.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Tangkapan tanggal: ${tangkapanIkan.tanggal}',
                style: TextStyle(
                  fontFamily: 'Lobster_Two',
                  fontSize: 30.0,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              // menonaktifkan scroll di ListView, ikuti ScrollView
              physics: NeverScrollableScrollPhysics(),
              children: tangkapanIkan.tangkapan.map((tangkapan) {
                Ikan ikan = tangkapan['jenis'];
                return Card(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 64.0, maxWidth: 64.0),
                                child: Image.asset(ikan.gambarAset)),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                '~ ${ikan.nama}: ${tangkapan['jumlah']} ekor',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          )),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
