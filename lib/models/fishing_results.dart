// model for sea animal caught by fisher

class Seafood {
  String name;
  String imageAsset;
  Seafood({this.name, this.imageAsset});
}

// model for fishing results of specific date

class FishingResults {
  String fishingDate;
  // Map: {"type": Seafood, "total": int}
  List<Map<String, Object>> results;
  FishingResults({this.fishingDate, this.results});
}
