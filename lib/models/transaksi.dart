class Transaksi {
  final String namaPembeli;
  final int jumlahTiket;
  final double totalHarga;
  final String filmTitle;
  final String kursiDipilih;
  final DateTime tanggalPembelian;

  Transaksi({
    required this.namaPembeli,
    required this.jumlahTiket,
    required this.totalHarga,
    required this.filmTitle,
    required this.kursiDipilih,
    required this.tanggalPembelian,
  });

  String? get filmPosterUrl => null;
}
