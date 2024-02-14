import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedOption1;
  String? selectedOption2;
  String? selectedOption3;

  Map<String, List<String>> options1 = {};
  Map<String, List<String>> options2 = {};
  Map<String, List<Map<String, dynamic>>> options3 = {};

  List<Map<String, dynamic>> danhSachMeCa = [];

  @override
  void initState() {
    super.initState();
    selectedOption1 = null;
    selectedOption2 = null;
    selectedOption3 = null;
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://mobileapi-production-85cd.up.railway.app/api/log/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];

      options1 = processOptions1(data);
      options2 = processOptions2(data);
      options3 = processOptions3(data);

      // Set initial values for dropdowns
      setState(() {
        selectedOption1 = options1.isNotEmpty ? options1.values.first.first : null;
        updateOptions2(); // Update options for the second dropdown
        selectedOption3 = options3[selectedOption1!]?.first['me_ca'].toString();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, List<String>> processOptions1(List<dynamic> data) {
    Map<String, List<String>> result = {};

    for (var item in data) {
      result[item['so_hieu_tau'].toString()] = [item['so_hieu_tau'].toString()];
    }

    return result;
  }

  Map<String, List<String>> processOptions2(List<dynamic> data) {
    Map<String, List<String>> result = {};
    for (var item in data) {
      List<dynamic>? danhSachChuyenBien = item['danh_sach_chuyen_bien'];
      if (danhSachChuyenBien != null) {
        result[item['so_hieu_tau']] = danhSachChuyenBien.map<String>((e) => e['chuyen_bien'].toString()).toList();
      }
    }
    return result;
  }

  Map<String, List<Map<String, dynamic>>> processOptions3(List<dynamic> data) {
    Map<String, List<Map<String, dynamic>>> result = {};
    for (var item in data) {
      List<dynamic>? danhSachMeCaApi = item['danh_sach_me_ca'];
      if (danhSachMeCaApi != null) {
        List<Map<String, dynamic>> danhSachMeCa = [];
        for (var meCa in danhSachMeCaApi) {
          List<dynamic>? duLieuMeCaApi = meCa['du_lieu_me_ca'];
          if (duLieuMeCaApi != null) {
            danhSachMeCa.add({
              'me_ca': meCa['me_ca'],
              'du_lieu_me_ca': List<Map<String, dynamic>>.from(duLieuMeCaApi),
            });
          }
        }
        result[item['so_hieu_tau']] = danhSachMeCa;
      }
    }
    return result;
  }

  void updateOptions2() {
    if (selectedOption1 != null) {
      setState(() {
        selectedOption2 = options2[selectedOption1!]?.first;
      });
    }
  }

  void updateDanhSachMeCa() {
    if (selectedOption1 != null && selectedOption3 != null) {
      danhSachMeCa = options3[selectedOption1!]!.where((meCa) => meCa['me_ca'].toString() == selectedOption3!).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDropDown('Tàu', options1.values.expand((element) => element).toList(), selectedOption1, (String? value) {
              setState(() {
                selectedOption1 = value;
                updateOptions2(); // Reset selectedOption2
                selectedOption3 = null;
                updateDanhSachMeCa();
              });
            }),
            SizedBox(height: 16),
            buildDropDown('Chuyến biển', options2[selectedOption1!] ?? [], selectedOption2, (String? value) {
              setState(() {
                selectedOption2 = value;
                selectedOption3 = null;
                updateDanhSachMeCa();
              });
            }),
            SizedBox(height: 16),
            buildDropDown('Mẻ cá', options3[selectedOption1!]?.map((e) => e['me_ca'].toString()).toList() ?? [], selectedOption3, (String? value) {
              setState(() {
                selectedOption3 = value;
                updateDanhSachMeCa();
              });
            }),
            SizedBox(height: 16),
            Text('Thông tin mẻ cá:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (selectedOption3 != null)
              Column(
                children: danhSachMeCa
                    .map((meCa) => Card(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('Mẻ cá ${meCa['me_ca']}'),
                      Divider(),
                      Column(
                        children: (meCa['du_lieu_me_ca'] as List<Map<String, dynamic>>)
                            .map((duLieu) => ListTile(
                          title: Text('${duLieu['ten_loai_ca']}: ${duLieu['khoi_luong']}'),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropDown(String label, List<String> options, String? selectedValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 20),
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: onChanged,
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
