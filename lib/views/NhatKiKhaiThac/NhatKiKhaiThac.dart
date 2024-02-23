import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../ChuyenTai/ChuyenTai.dart';

class NhatKi extends StatefulWidget {
  const NhatKi({Key? key}) : super(key: key);

  @override
  _NhatKiState createState() => _NhatKiState();
}

class _NhatKiState extends State<NhatKi> {
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
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://mobileapi-production-85cd.up.railway.app/api/log/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        options1 = processOptions1(data);
        options2 = processOptions2(data);
        options3 = processOptions3(data);

        setState(() {
          selectedOption1 = options1.isNotEmpty ? options1.keys.first : null;
          selectedOption2 = '2';
          selectedOption3 = '1'; // Set the default value for Mẻ cá to '1'
          updateDanhSachMeCa();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
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
      if (danhSachChuyenBien != null && danhSachChuyenBien.isNotEmpty) {
        result[item['so_hieu_tau']] = danhSachChuyenBien.map<String>((e) => e['chuyen_bien'].toString()).toList();
      }
    }

    return result;
  }

  Map<String, List<Map<String, dynamic>>> processOptions3(List<dynamic> data) {
    Map<String, List<Map<String, dynamic>>> result = {};

    for (var item in data) {
      List<dynamic>? danhSachMeCaApi = item['danh_sach_me_ca'];
      if (danhSachMeCaApi != null && danhSachMeCaApi.isNotEmpty) {
        List<Map<String, dynamic>> danhSachMeCa = [];
        for (var meCa in danhSachMeCaApi) {
          List<dynamic>? duLieuMeCaApi = meCa['du_lieu_me_ca'];
          if (duLieuMeCaApi != null && duLieuMeCaApi.isNotEmpty) {
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

  void updateDanhSachMeCa() {
    if (selectedOption1 != null && selectedOption3 != null) {
      danhSachMeCa = options3[selectedOption1!]!.where((meCa) => meCa['me_ca'].toString() == selectedOption3!).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Nhật kí khai thác',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.06,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.height * 0.018),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Số hiệu tàu:',
                          style: TextStyle(fontSize: screenSize.width * 0.045),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenSize.width * 0.03),
                          child: DropdownButton<String>(
                            value: selectedOption1,
                            onChanged: (String? value) {
                              setState(() {
                                selectedOption1 = value;
                                selectedOption2 = '2';
                                selectedOption3 = '1'; // Reset Mẻ cá to '1' when changing tàu
                                updateDanhSachMeCa();
                              });
                            },
                            items: options1.values
                                .expand((element) => element)
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Chuyến biển: ',
                          style: TextStyle(fontSize: screenSize.width * 0.045),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenSize.width * 0.03),
                          child: Text(selectedOption2 ?? '1', style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.width * 0.04,
                          bottom: screenSize.height * 0.05),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChuyenTai()));
                          // Navigate to ChuyenTai screen
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text(
                          'Chuyển tải',
                          style: TextStyle(
                              fontSize: screenSize.width * 0.043,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.005,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mẻ cá: ',
                          style: TextStyle(fontSize: screenSize.width * 0.045),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenSize.width * 0.03),
                          child: DropdownButton<String>(
                            value: selectedOption3,
                            onChanged: (String? value) {
                              setState(() {
                                selectedOption3 = value;
                                updateDanhSachMeCa();
                              });
                            },
                            items: options3[selectedOption1!]?.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                              value: e['me_ca'].toString(),
                              child: Text(e['me_ca'].toString()),
                            )).toList() ?? [],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/sort.png',
                      width: screenSize.width * 0.06,
                      height: screenSize.height * 0.06,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.005),
            Container(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: screenSize.height * 0.03),
            Text('Thông tin mẻ cá', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (selectedOption3 != null)
              Column(
                children: danhSachMeCa
                    .map((meCa) => Card(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
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
}
