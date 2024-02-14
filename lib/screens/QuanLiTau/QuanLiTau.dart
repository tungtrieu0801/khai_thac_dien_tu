import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:originproject/components/widget_support.dart';

class QuanLiTau extends StatefulWidget {
  @override
  _QuanLiTauState createState() => _QuanLiTauState();
}

class Boat {
  final int soHieuTau;
  final String thuyenTruong;
  final String loaiThietBi;
  final String tenThietBi;
  final String imo;
  final String soKepChi;
  final String ngayNiemPhong;

  Boat({
    required this.soHieuTau,
    required this.thuyenTruong,
    required this.loaiThietBi,
    required this.tenThietBi,
    required this.imo,
    required this.soKepChi,
    required this.ngayNiemPhong,
  });
}

class _QuanLiTauState extends State<QuanLiTau> {
  int selectedTrainIndex = -1;
  List<Boat> boatList = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Gọi hàm fetch dữ liệu khi khởi tạo Widget
  }

  // Hàm fetch dữ liệu từ API
  void fetchData() async {
    final response = await http.get(Uri.parse(
        'https://mobileapi-production-85cd.up.railway.app/api/boat_list/'));

    if (response.statusCode == 200) {
      // Nếu fetch thành công
      final List<dynamic> jsonData = json.decode(response.body)['boat_list'];

      setState(() {
        // Cập nhật danh sách tàu từ API
        boatList = jsonData
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
      });
    } else {
      // Nếu fetch không thành công, xử lý lỗi ở đây
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Quản lí tàu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: boatList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    color: Color(0xFFFEEAE6),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'lib/assets/images/bg.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tàu ${boatList[index].soHieuTau}',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Colors.green
                              ),

                                onPressed: () {
                                  setState(() {
                                    selectedTrainIndex = (selectedTrainIndex == index) ? -1 :index;
                                  });
                                },
                                child: Text("Thông tin", style: AppWidget.buttonText(),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1),
                    height: selectedTrainIndex == index ? 400 : 0,
                    curve: Curves.easeInOut,
                    child: selectedTrainIndex == index
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Thuộc tính')),
                          DataColumn(label: Text('Giá trị')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Số hiệu tàu')),
                            DataCell(Text(boatList[index].soHieuTau.toString())),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Thuyền trưởng')),
                            DataCell(Text(boatList[index].thuyenTruong)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Loại thiết bị')),
                            DataCell(Text(boatList[index].loaiThietBi)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Tên thiết bị')),
                            DataCell(Text(boatList[index].tenThietBi)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Số imeil')),
                            DataCell(Text(boatList[index].imo)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Số kẹp chì')),
                            DataCell(Text(boatList[index].soKepChi)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ngày niêm phong')),
                            DataCell(Text(boatList[index].ngayNiemPhong)),
                          ]),
                        ],
                      ),
                    )
                        : Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
