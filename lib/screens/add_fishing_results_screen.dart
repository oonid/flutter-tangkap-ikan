import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/fishing_results.dart';
import 'package:tangkap_ikan/screens/add_seafood_screen.dart';

// the screen to add fishing results by fisher
// using Stateful Widget to implement Form inside the screen

class AddFishingResultsScreen extends StatefulWidget {
  @override
  _AddFishingResultsScreenState createState() =>
      _AddFishingResultsScreenState();
}

class _AddFishingResultsScreenState extends State<AddFishingResultsScreen> {
  // create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  // note: this is a `GlobalKey<FormState>`,
  // not a GlobalKey<_AddFishingResultsScreenState>
  final _formKey = GlobalKey<FormState>();

  List<Map<String, Object>> results = List();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        // limit the date selection only for last 30 days
        firstDate: DateTime.now().subtract(Duration(days: 30)),
        // set last date as today (now)
        lastDate: DateTime.now());
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text("Tanggal: " + "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontFamily: 'Lobster_Two',
                        fontSize: 30.0,
                      )),
                  FlatButton(
                    child: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  )
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 256.0, minHeight: 64.0),
                child: ListView(
                  shrinkWrap: true,
                  children: results.map((m) {
                    Seafood seafood = m['type'];
                    return Card(
                      child: Text('~ ${seafood.name}: ${m['total']} ekor'),
                    );
                  }).toList(),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  // validate will return true if the form valid
                  if (_formKey.currentState.validate()) {
                    // the form is valid, process the form data

                    // call save() will trigger onSaved on every Form fields
                    _formKey.currentState.save();

                    // returns FishingResults
                    // previous screen awaits for returns from Navigator.pop
                    Navigator.pop(
                        context,
                        FishingResults(
                            fishingDate: '${selectedDate.year}-'
                                '${selectedDate.month}-'
                                '${selectedDate.day}',
                            results: results));
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
          onPressed: () => _navigationToFormScreen(context),
        ),
      ),
    );
  }

  // A method that launches the AddSeafoodScreen and awaits the
  // result from Navigator.pop.
  _navigationToFormScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.

    // result is Map {'type': Seafood, 'total' int}
    final Map result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSeafoodScreen()),
    );

    if (result != null && result.containsKey('total') && result['total'] > 0) {
      // added seafood is not null, its Map has total key and greater than 0

      setState(() => results.add(result));

      // after AddSeafood returns result and added to the list,
      // display the data with SnackBar
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('${result['type'].name}: ${result['total']} ekor'),
        ));
    } else {
      // empty result, inform that no data being added

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text('Ikan Kosong (tidak ditambahkan).')));
    }
  }
}
