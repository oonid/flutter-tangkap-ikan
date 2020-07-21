import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/fishing_results.dart';

// the screen to add sea animal (seafood) caught by fisher
// using Stateful Widget to implement Form inside the screen

class AddSeafoodScreen extends StatefulWidget {
  @override
  _AddSeafoodScreenState createState() => _AddSeafoodScreenState();
}

class _AddSeafoodScreenState extends State<AddSeafoodScreen> {
  // create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  // note: this is a `GlobalKey<FormState>`,
  // not a GlobalKey<_AddSeafoodScreenState>
  final _formKey = GlobalKey<FormState>();

  Seafood selectedSeafood;
  int totalSeafood;

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
              DropdownButtonFormField<Seafood>(
                value: selectedSeafood,
                hint: Text('Pilihan Ikan'),
                decoration: InputDecoration(
                  hintText: 'Pilihan Ikan',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                items: seafoodSelectionList
                    .map<DropdownMenuItem<Seafood>>((Seafood seafood) {
                  return DropdownMenuItem<Seafood>(
                    value: seafood,
                    child: Text(seafood.name),
                  );
                }).toList(),
                onChanged: (seafood) =>
                    setState(() => selectedSeafood = seafood),
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
                onSaved: (value) => totalSeafood = int.tryParse(value) ?? 0,
              ),
              RaisedButton(
                onPressed: () {
                  // validate will return true if the form valid
                  if (_formKey.currentState.validate()) {
                    // the form is valid, process the form data

                    // call save() will trigger onSaved on every Form fields
                    _formKey.currentState.save();

                    // returns Map of seafood type and total
                    // previous screen awaits for returns from Navigator.pop
                    Navigator.pop(context,
                        {'type': selectedSeafood, 'total': totalSeafood});
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

// the sea animal still use Bahasa Indonesia for the shake of user experience

var seafoodSelectionList = [
  Seafood(name: 'Baronang', imageAsset: 'images/baronang.jpg'),
  Seafood(name: 'Kerapu', imageAsset: 'images/kerapu.jpg'),
  Seafood(name: 'Kakap Merah', imageAsset: 'images/kakap-merah.jpg'),
  Seafood(name: 'Cumi', imageAsset: 'images/cumi.jpg'),
  Seafood(name: 'Udang', imageAsset: 'images/udang.jpg'),
  Seafood(name: 'Kepiting', imageAsset: 'images/kepiting.jpg'),
];
