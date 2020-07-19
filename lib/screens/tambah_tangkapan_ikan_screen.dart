import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';
import 'package:tangkap_ikan/screens/tambah_ikan_screen.dart';

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
                  Text(
                      "Tanggal: " +
                          "${tanggalTerpilih.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontFamily: 'Lobster_Two',
                        fontSize: 30.0,
                      )),
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
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: const Icon(Icons.add_shopping_cart),
          tooltip: 'Tambah Ikan',
          onPressed: () => _navigasiTambahIkan(context),
        ),
      ),
    );
  }

  // sebuah method yang menampilkan TambahIkan dan menunggu (awaits)
  // hasil Map jenis dan jumlah ikan dari Navigator.pop
  _navigasiTambahIkan(BuildContext context) async {
    // Navigator.push mengembalikan Future yang akan selesai saat pemanggilan
    // Navigator.pop di TambahIkanScreen.

    // result adalah Map {'jenis': Ikan, 'jumlah': i}
    final Map result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahIkanScreen()),
    );

    if (result != null &&
        result.containsKey('jumlah') &&
        result['jumlah'] > 0) {
      // tambahan ikan tidak null, Map mengandung kata kunci jumlah, dan jumlah
      // tambahan ikan lebih besar dari nol

      setState(() {
        tangkapan.add(result);
      });

      // setelah TambahTangkapanIkan mengembalikan hasil, tampilkan kembalian
      // datanya dengan SnackBar
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content:
                Text('${result['jenis'].nama}: ${result['jumlah']} ekor')));
    } else {
      // data kosong, informasikan bahwa tidak ditambahkan

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text('Ikan Kosong (tidak ditambahkan).')));
    }
  }
}
