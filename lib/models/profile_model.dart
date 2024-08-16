class ProfileModel {
  final String? token;
  final String? fullname;
  final String? motherName;
  final String? rmNumber;
  final String? dateBirth;
  final String? age;
  final String? bpjsNumber;
  final String? placeBirth;
  String? gender;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? idType;
  final String? idNumber;
  final String? religion;
  final String? ethnic;
  final String? language;
  final String? rt;
  final String? rw;
  final String? province;
  final String? city;
  final String? subdistrict;
  final String? village;
  final String? postalCode;
  final String? address;
  final String? domAddress;
  final String? domRt;
  final String? domRw;
  final String? domVillage;
  final String? domSubdistrict;
  final String? domCity;
  final String? domProvince;
  final String? domPostalCode;
  final String? domPhoneNumber;
  final String? education;
  final String? job;
  final String? maritalStatus;
  final String? category;
  final String? pembiayaan;
  final String? img;
  final String? ihsId;

  ProfileModel({
    String? this.token,
    String? this.fullname,
    String? this.motherName,
    String? this.rmNumber,
    String? this.dateBirth,
    String? this.age,
    String? this.bpjsNumber,
    String? this.placeBirth,
    String? this.gender,
    String? this.phoneNumber,
    String? this.email,
    String? this.password,
    String? this.idType,
    String? this.idNumber,
    String? this.religion,
    String? this.ethnic,
    String? this.language,
    String? this.rt,
    String? this.rw,
    String? this.province,
    String? this.city,
    String? this.subdistrict,
    String? this.village,
    String? this.postalCode,
    String? this.address,
    String? this.domAddress,
    String? this.domRt,
    String? this.domRw,
    String? this.domVillage,
    String? this.domSubdistrict,
    String? this.domCity,
    String? this.domProvince,
    String? this.domPostalCode,
    String? this.domPhoneNumber,
    String? this.education,
    String? this.job,
    String? this.maritalStatus,
    String? this.category,
    String? this.pembiayaan,
    String? this.img,
    String? this.ihsId,
  });

  // Factory method to create a Profile object from JSON
  factory ProfileModel.fromApiJson(Map<String, dynamic> json, {String? token}) {
    return ProfileModel(
      token: token ?? json['uniq_code'],
      fullname: json['data'][0]['nama_lengkap'],
      motherName: json['data'][0]['nama_ibu'],
      rmNumber: json['data'][0]['no_rm'],
      dateBirth: json['data'][0]['tgl_lahir'],
      age: json['data'][0]['umur'],
      bpjsNumber: json['data'][0]['no_bpjs'],
      placeBirth: json['data'][0]['tempat_lahir'],
      gender: json['data'][0]['jenis_kelamin'],
      phoneNumber: json['data'][0]['nohp'],
      email: json['data'][0]['email'],
      password: json['data'][0]['password'],
      idType: json['data'][0]['jenis_identitas'],
      idNumber: json['data'][0]['no_identitas'],
      religion: json['data'][0]['agama'],
      ethnic: json['data'][0]['suku'],
      language: json['data'][0]['bahasa'],
      rt: json['data'][0]['rt'],
      rw: json['data'][0]['rw'],
      province: json['data'][0]['provinsi'],
      city: json['data'][0]['kota'],
      subdistrict: json['data'][0]['kecamatan'],
      village: json['data'][0]['kecamatan'],
      postalCode: json['data'][0]['kode_pos'],
      address: json['data'][0]['alamat'],
      domAddress: json['data'][0]['alamat_dom'],
      domRt: json['data'][0]['rt_dom'],
      domRw: json['data'][0]['rw_dom'],
      domVillage: json['data'][0]['kelurahan_dom'],
      domSubdistrict: json['data'][0]['kecamatan_dom'],
      domCity: json['data'][0]['kota_dom'],
      domProvince: json['data'][0]['provinsi_dom'],
      domPostalCode: json['data'][0]['kode_pos_dom'],
      domPhoneNumber: json['data'][0]['no_telp'],
      education: json['data'][0]['pendidikan'],
      job: json['data'][0]['pekerjaan'],
      maritalStatus: json['data'][0]['status_nikah'],
      category: json['data'][0]['kategori'],
      pembiayaan: json['data'][0]['pembiayaan'],
      img: json['data'][0]['foto'],
      ihsId: json['data'][0]['ihs_id'],
    );
  }

  // Factory method to create a Profile object from JSON
  factory ProfileModel.fromLocalJson(Map<String, dynamic> json) {
    return ProfileModel(
      token: json['token'],
      fullname: json['fullname'],
      motherName: json['motherName'],
      rmNumber: json['rmNumber'],
      dateBirth: json['dateBirth'],
      age: json['age'],
      bpjsNumber: json['bpjsNumber'],
      placeBirth: json['placeBirth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      idType: json['idType'],
      idNumber: json['idNumber'],
      religion: json['religion'],
      ethnic: json['ethnic'],
      language: json['language'],
      rt: json['rt'],
      rw: json['rw'],
      province: json['province'],
      city: json['city'],
      subdistrict: json['subdistrict'],
      village: json['village'],
      postalCode: json['postalCode'],
      address: json['address'],
      domAddress: json['domAddress'],
      domRt: json['domRt'],
      domRw: json['domRw'],
      domVillage: json['domVillage'],
      domSubdistrict: json['domSubdistrict'],
      domCity: json['domCity'],
      domProvince: json['domProvince'],
      domPostalCode: json['domPostalCode'],
      domPhoneNumber: json['domPhoneNumber'],
      education: json['education'],
      job: json['job'],
      maritalStatus: json['maritalStatus'],
      category: json['category'],
      pembiayaan: json['pembiayaan'],
      img: json['img'],
      ihsId: json['ihsId'],
    );
  }

  // Method to convert a Profile object to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'fullname': fullname,
      'motherName': motherName,
      'rmNumber': rmNumber,
      'dateBirth': dateBirth,
      'age': age,
      'bpjsNumber': bpjsNumber,
      'placeBirth': placeBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'idType': idType,
      'idNumber': idNumber,
      'religion': religion,
      'ethnic': ethnic,
      'language': language,
      'rt': rt,
      'rw': rw,
      'province': province,
      'city': city,
      'subdistrict': subdistrict,
      'village': village,
      'postalCode': postalCode,
      'address': address,
      'domAddress': domAddress,
      'domRt': domRt,
      'domRw': domRw,
      'domVillage': domVillage,
      'domSubdistrict': domSubdistrict,
      'domCity': domCity,
      'domProvince': domProvince,
      'domPostalCode': domPostalCode,
      'domPhoneNumber': domPhoneNumber,
      'education': education,
      'job': job,
      'maritalStatus': maritalStatus,
      'category': category,
      'pembiayaan': pembiayaan,
      'img': img,
      'ihsId': ihsId,
    };
  }
}
