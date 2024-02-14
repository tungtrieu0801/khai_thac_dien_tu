import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:originproject/components/myButton.dart';

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
    final response = await http.get(Uri.parse('https://mobileapi-production-85cd.up.railway.app/api/boat_list/'));

    if (response.statusCode == 200) {
      // Nếu fetch thành công
      final List<dynamic> jsonData = json.decode(response.body)['boat_list'];

      setState(() {
        // Cập nhật danh sách tàu từ API
        boatList = jsonData.map((json) => Boat(
          soHieuTau: json['so_hieu_tau'],
          thuyenTruong: json['thuyen_truong'],
          loaiThietBi: json['loai_thiet_bi'],
          tenThietBi: json['ten_thiet_bi'],
          imo: json['IMO'],
          soKepChi: json['so_kep_chi'],
          ngayNiemPhong: json['ngay_niem_phong'],
        )).toList();
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
        title: const Text(

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
                  ListTile(
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
                              'Tàu ${boatList[index].soHieuTau}-2931278',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: MyButton(
                              onTap: () {
                                setState(() {
                                  selectedTrainIndex =
                                  (selectedTrainIndex == index) ? -1 : index;
                                });
                              },
                              color: Colors.green,
                              text: 'Thông tin',
                              width: 100,
                              height: 40,
                              textStyle: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1),
                    height: selectedTrainIndex == index ? 200 : 0,
                    curve: Curves.easeInOut,
                    child: selectedTrainIndex == index
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Số hiệu tàu ${boatList[index].soHieuTau}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  'Thuyền trưởng: ${boatList[index].thuyenTruong}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  'Loại thiết bị: ${boatList[index].loaiThietBi}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  'Tên thiết bị: ${boatList[index].tenThietBi}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  'Số imeil: ${boatList[index].imo}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  "Số kẹp chì: ${boatList[index].soKepChi}",
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  "Ngày niêm phong: ${boatList[index].ngayNiemPhong}",
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                )
                              ],
                            ),
                          ),
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
