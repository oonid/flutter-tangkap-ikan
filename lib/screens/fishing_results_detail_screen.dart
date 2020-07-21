import 'package:flutter/material.dart';
import 'package:tangkap_ikan/models/fishing_results.dart';

// detail screen of the fishing result at single day
// using Stateless Widget as no state changed on this screen

class FishingResultsDetailScreen extends StatelessWidget {
  final FishingResults fishingResults;

  FishingResultsDetailScreen(this.fishingResults);

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
                'Tangkapan tanggal: ${fishingResults.fishingDate}',
                style: TextStyle(
                  fontFamily: 'Lobster_Two',
                  fontSize: 30.0,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              // deactivate scroll on ListView, will use scroll from ScrollView
              physics: NeverScrollableScrollPhysics(),
              children: fishingResults.results.map((results) {
                Seafood seafood = results['type'];
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
                              child: Image.asset(seafood.imageAsset),
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                '~ ${seafood.name}: ${results['total']} ekor',
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
