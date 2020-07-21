import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/fishing_results.dart';
import 'package:tangkap_ikan/screens/fishing_results_detail_screen.dart';
import 'package:tangkap_ikan/screens/add_fishing_results_screen.dart';

// HomeScreen as Stateful Widget with changed state of fishingResultList

class HomeScreen extends StatefulWidget {
  final List<FishingResults> fishingResultsList;

  HomeScreen({Key key, this.fishingResultsList}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nelayan Tangkap Ikan',
            style: TextStyle(
                fontFamily: 'Lobster_Two',
                fontStyle: FontStyle.italic,
                fontSize: 30.0)),
      ),
      body: ListView(
        children: widget.fishingResultsList
            .where((fishingResults) => fishingResults.results.length > 0)
            .map((fishingResults) {
          String imageAsset = '';
          String displayedText = '';
          int maxShowData = 2; // display max 2 seafood data

          // iterate fishingResults, has 1 data at minimum
          int maxTotal = 0;
          fishingResults.results.asMap().forEach((idx, results) {
            Seafood seafood = results['type'];
            int total = results['total'];
            if (imageAsset == '') imageAsset = seafood.imageAsset; // initial
            if (total > maxTotal) {
              // display only 1 image from the top type of results
              maxTotal = total;
              imageAsset = seafood.imageAsset;
            }
            if (idx < maxShowData) {
              if (idx > 0) displayedText += ' '; // space between sentences
              displayedText += '${seafood.name}: $total ekor.';
            } else if (idx == maxShowData) {
              displayedText += '..'; // dst
            }
          });

          // isi dari ListView
          return FlatButton(
            onPressed: () {
              Navigator.of(context).push(_routeToDetail(fishingResults));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
                        child: Image.asset(imageAsset),
                      ),
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
                            'Tangkapan tanggal: ${fishingResults.fishingDate}',
                            style: TextStyle(
                              fontFamily: 'Lobster_Two',
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            displayedText,
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
      floatingActionButton: Builder(
        // using Builder to be able to pass context in Scaffold.of()
        builder: (context) => FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Tambah Tangkapan Ikan',
          onPressed: () => _navigationToFormScreen(context),
        ),
      ),
    );
  }

  // A method that launches the AddFishingResultsScreen and awaits the
  // result from Navigator.pop.
  _navigationToFormScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final FishingResults result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFishingResultsScreen()),
    );

    if (result != null && result.results.length > 0) {
      // result of FishingResults is not null and has results Map on it

      setState(() => widget.fishingResultsList.add(result));

      // after AddFishingResults returns result and added to the list,
      // display the data with SnackBar
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('Tangkapan Tanggal: ${result.fishingDate}'),
        ));
    } else {
      // empty result, inform that no data being added

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text('Tangkapan Kosong (tidak ditambahkan).')));
    }
  }

  Route _routeToDetail(fishingResults) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishingResultsDetailScreen(fishingResults),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
