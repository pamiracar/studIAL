class Ilan {
  final String id;
  final String yayinlanmaTarihi;
  final String verilecekDers;
  final String alinacakDers;
  final String userId;
  final String userName;
  final String classLevel;

  Ilan({
    required this.id,
    required this.yayinlanmaTarihi,
    required this.verilecekDers,
    required this.alinacakDers,
    required this.userId,
    required this.userName,
    required this.classLevel,
  });

  factory Ilan.fromJson(Map<String, dynamic> json) {
    return Ilan(
      id: json['id'] as String,
      yayinlanmaTarihi: json['yayinlanma_tarihi'] as String,
      verilecekDers: json['verilecek_ders'] as String,
      alinacakDers: json['alinacak_ders'] as String,
      userId: json['user_id'] as String,
      userName: json["user_name"] as String,
      classLevel: json["class_level"] as String,
    );
  }
}
