import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/boatModel.dart';

class ApiService {
  Future<void> fetchData(Function(List<Boat>) onDataLoaded) async {
    final response = await http.get(Uri.parse(
        'https://mobileapi-production-85cd.up.railway.app/api/boat_list/'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['boat_list'];

      List<Boat> boatList = jsonData
          .map((json) => Boat(
        soHieuTau: json['so_hieu_tau'],
        thuyenTruong: json['thuyen_truong'],
        loaiThietBi: json['loai_thiet_bi'],
        tenThietBi: json['ten_thiet_bi'],
        imo: json['IMO'],
        soKepChi: json['so_kep_chi'],
        ngayNiemPhong: json['ngay_niem_phong'],
      ))
          .toList();

      onDataLoaded(boatList);
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

}
