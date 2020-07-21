import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/fishing_results.dart';
import 'package:tangkap_ikan/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(TangkapIkanApp());
}

// the app name is TangkapIkan (we'll keep it in Bahasa Indonesia)
// using Stateful Widget to show splash screen

class TangkapIkanApp extends StatefulWidget {
  @override
  _TangkapIkanAppState createState() => _TangkapIkanAppState();
}

class _TangkapIkanAppState extends State<TangkapIkanApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomeScreen(
          fishingResultsList: fishingResultsList,
        ),
        image: Image.asset('images/tangkap_ikan.png'),
        backgroundColor: Colors.white,
        photoSize: 80.0,
        loaderColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

// this is initial data that will shown as fishing results when the app starting
// from this list then user can add new fishing results
// the sea animal still use Bahasa Indonesia for the shake of user experience

var fishingResultsList = [
  FishingResults(
    fishingDate: '2020-07-03',
    results: [
      {
        'type': Seafood(name: 'Baronang', imageAsset: 'images/baronang.jpg'),
        'total': 11,
      },
      {
        'type': Seafood(name: 'Kerapu', imageAsset: 'images/kerapu.jpg'),
        'total': 10,
      }
    ],
  ),
  FishingResults(
    fishingDate: '2020-07-04',
    results: [
      {
        'type':
            Seafood(name: 'Kakap Merah', imageAsset: 'images/kakap-merah.jpg'),
        'total': 12,
      },
    ],
  ),
  FishingResults(
    fishingDate: '2020-07-05',
    results: [],
  ),
  FishingResults(
    fishingDate: '2020-07-06',
    results: [
      {
        'type': Seafood(name: 'Cumi', imageAsset: 'images/cumi.jpg'),
        'total': 12,
      },
      {
        'type': Seafood(name: 'Udang', imageAsset: 'images/udang.jpg'),
        'total': 11,
      },
      {
        'type': Seafood(name: 'Kepiting', imageAsset: 'images/kepiting.jpg'),
        'total': 10,
      },
    ],
  ),
];
