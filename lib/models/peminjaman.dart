class Peminjaman {
  final int id;
  final String namaAlat;
  final String kodeAlat;
  final int waktuPinjam;
  final int waktuKembali;
  final bool dikembalikan;
  final String peminjam;

  const Peminjaman({
    required this.id,
    required this.namaAlat,
    required this.kodeAlat,
    required this.waktuPinjam,
    required this.waktuKembali,
    required this.dikembalikan,
    required this.peminjam,
  });

  factory Peminjaman.fromTuple(List<dynamic> data) {
    return Peminjaman(
      id: (data[0] as BigInt).toInt(),
      namaAlat: data[1].toString(),
      kodeAlat: data[2].toString(),
      waktuPinjam: (data[3] as BigInt).toInt(),
      waktuKembali: (data[4] as BigInt).toInt(),
      dikembalikan: data[5] as bool,
      peminjam: data[6].toString(),
    );
  }

  DateTime get tanggalPinjam =>
      DateTime.fromMillisecondsSinceEpoch(waktuPinjam * 1000);

  DateTime? get tanggalKembali {
    if (waktuKembali == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(waktuKembali * 1000);
  }
}
