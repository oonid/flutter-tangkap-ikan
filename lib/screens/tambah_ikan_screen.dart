import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/tangkapan_ikan.dart';

// halaman untuk menambah data ikan dll pada suatu tangkapan
// merupakan Stateful Widget karena berisi formulir

class TambahIkanScreen extends StatefulWidget {
  @override
  _TambahIkanScreenState createState() => _TambahIkanScreenState();
}

class _TambahIkanScreenState extends State<TambahIkanScreen> {
  // membuat key global yang unik untuk mengidentifikasi widget Form dan
  // juga digunakan untuk dapat melakukan validasi dari form

  // perhatikan bahwa ini `GlobalKey<FormState>`,
  // bukan GlobalKey<_TambahTangkapanIkanScreenState>
  final _formKey = GlobalKey<FormState>();

  Ikan ikanTerpilih;
  int jumlahIkan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Ikan',
            style: TextStyle(
                fontFamily: 'Lobster_Two',
                fontStyle: FontStyle.italic,
                fontSize: 30.0)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<Ikan>(
                value: ikanTerpilih,
                hint: Text('Pilihan Ikan'),
                decoration: InputDecoration(
                  hintText: 'Pilihan Ikan',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                items: pilihanIkanList.map<DropdownMenuItem<Ikan>>((Ikan ikan) {
                  return DropdownMenuItem<Ikan>(
                    value: ikan,
                    child: Text(ikan.nama),
                  );
                }).toList(),
                onChanged: (ikan) => setState(() => ikanTerpilih = ikan),
                validator: (value) => value == null ? 'pilih ikan' : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                  hintText: 'Jumlah Ikan',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty || (int.tryParse(value) ?? 0) < 1)
                    return 'masukkan jumlah ikan';
                  return null; // valid
                },
                onSaved: (value) => jumlahIkan = int.tryParse(value) ?? 0,
              ),
              RaisedButton(
                onPressed: () {
                  // validasi akan mengembalikan true jika form valid
                  if (_formKey.currentState.validate()) {
                    // form valid, lakukan pemrosesan selanjutnya

                    // panggil save() yang akan membuat masing-masing Form Field
                    // memanggil onSaved yang terdefinisi
                    _formKey.currentState.save();

                    // mengembalikan Map jenis dan jumlah ikan
                    // karena Screen sebelumnya menunggu (awaits) kembalian
                    // data dari Navigator.pop
                    Navigator.pop(
                        context, {'jenis': ikanTerpilih, 'jumlah': jumlahIkan});
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

var pilihanIkanList = [
  Ikan(nama: 'Baronang', gambarAset: 'images/baronang.jpg'),
  Ikan(nama: 'Kerapu', gambarAset: 'images/kerapu.jpg'),
  Ikan(nama: 'Kakap Merah', gambarAset: 'images/kakap-merah.jpg'),
  Ikan(nama: 'Cumi', gambarAset: 'images/cumi.jpg'),
  Ikan(nama: 'Udang', gambarAset: 'images/udang.jpg'),
  Ikan(nama: 'Kepiting', gambarAset: 'images/kepiting.jpg'),
];
