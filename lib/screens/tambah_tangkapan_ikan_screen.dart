import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';

// halaman untuk menambah data tangkapan ikan pada suatu hari/tanggal
// merupakan Stateful Widget karena akan berisi formulir

class TambahTangkapanIkanScreen extends StatefulWidget {
  @override
  _TambahTangkapanIkanScreenState createState() =>
      _TambahTangkapanIkanScreenState();
}

class _TambahTangkapanIkanScreenState extends State<TambahTangkapanIkanScreen> {
  // membuat key global yang unik untuk mengidentifikasi widget Form dan
  // juga digunakan untuk dapat melakukan validasi dari form

  // perhatikan bahwa ini `GlobalKey<FormState>`,
  // bukan GlobalKey<_TambahTangkapanIkanScreenState>

  final _formKey = GlobalKey<FormState>();
  List<Map<String, Object>> tangkapan = List();
  DateTime tanggalTerpilih = DateTime.now();

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime terpilih = await showDatePicker(
        context: context,
        initialDate: tanggalTerpilih,
        // membatasi tanggal hanya 30 hari terakhir
        firstDate: DateTime.now().subtract(Duration(days: 30)),
        // pilih akhir tanggal adalah hari tersebut
        lastDate: DateTime.now());
    if (terpilih != null && terpilih != tanggalTerpilih)
      setState(() {
        tanggalTerpilih = terpilih;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tangkapan Ikan',
            style: TextStyle(
                fontFamily: 'Lobster_Two',
                fontStyle: FontStyle.italic,
                fontSize: 30.0)),
      ),
      body: Builder(
        // menggunakan builder agar bisa memanggil context di Scaffold.of()
        builder: (context) => Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text("Tanggal: " +
                      "${tanggalTerpilih.toLocal()}".split(' ')[0]),
                  FlatButton(
                    child: const Icon(Icons.calendar_today),
                    onPressed: () => _pilihTanggal(context),
                  )
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 256.0, minHeight: 64.0),
                child: ListView(
                  shrinkWrap: true,
                  children: tangkapan.map((m) {
                    Ikan ikan = m['jenis'];
                    return Card(
                      child: Text('~ Ikan ${ikan.nama}: ${m['jumlah']} ekor'),
                    );
                  }).toList(),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  // validasi akan mengembalikan true jika form valid
                  if (_formKey.currentState.validate()) {
                    // form valid, lakukan pemrosesan selanjutnya

                    // panggil save() yang akan membuat masing-masing Form Field
                    // memanggil onSaved yang terdefinisi
                    _formKey.currentState.save();

                    // mengembalikan TangkapanIkan karena Screen sebelumnya
                    // menunggu (awaits) kembalian data dari Navigator.pop
                    Navigator.pop(
                        context,
                        TangkapanIkan(
                            tanggal: '${tanggalTerpilih.year}-'
                                '${tanggalTerpilih.month}-'
                                '${tanggalTerpilih.day}',
                            tangkapan: tangkapan));
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart),
        tooltip: 'Tambah Ikan',
        onPressed: () {},
      ),
    );
  }
}
