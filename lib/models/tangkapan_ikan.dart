// model untuk hasil tangkapan nelayan
// sementara menggunakan nama "Ikan" meski menyertakan jenis lain (udang, dll)

class Ikan {
  String nama;
  String gambarAset;
  Ikan({this.nama, this.gambarAset});
}

// model untuk tangkapan nelayan pada hari/tanggal tertentu

class TangkapanIkan {
  String tanggal;
  // Map: "jenis": Ikan, "jumlah": int
  List<Map<String, Object>> tangkapan;
  TangkapanIkan({this.tanggal, this.tangkapan});
}
