class ProvinceDistrictModel {
  final String id;
  final String name;

  ProvinceDistrictModel({
    required this.id,
    required this.name,
  });

  factory ProvinceDistrictModel.fromMapEntry(MapEntry<String, dynamic> entry) {
    return ProvinceDistrictModel(
      id: entry.key,
      name: entry.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

List<ProvinceDistrictModel> parseProvincesDistricts(Map<String, dynamic> json) {
  return json.entries
      .map((entry) => ProvinceDistrictModel.fromMapEntry(entry))
      .toList();
}
