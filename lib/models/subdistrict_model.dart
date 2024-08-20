class SubdistrictModel {
  final String kecamatan;
  final String kelurahan;
  final String kodepos;

  SubdistrictModel({
    required this.kecamatan,
    required this.kelurahan,
    required this.kodepos,
  });

  factory SubdistrictModel.fromJson(Map<String, dynamic> json) {
    return SubdistrictModel(
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      kodepos: json['kodepos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'kodepos': kodepos,
    };
  }
}

List<SubdistrictModel> parseSubdistricts(List<dynamic> jsonList) {
  return jsonList.map((json) => SubdistrictModel.fromJson(json)).toList();
}
