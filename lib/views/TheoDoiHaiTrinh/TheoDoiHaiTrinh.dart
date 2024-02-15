import 'package:flutter/material.dart';
import 'package:originproject/components/myButton.dart';

import '../../components/PoliMap.dart';
import '../../components/dropdown.dart';

class TheoDoiHaiTrinh extends StatefulWidget {
  final String tenTau;

  const TheoDoiHaiTrinh({Key? key, required this.tenTau}) : super(key: key);

  @override
  State<TheoDoiHaiTrinh> createState() => _TheoDoiHaiTrinhState();
}

class _TheoDoiHaiTrinhState extends State<TheoDoiHaiTrinh> {
  String selectedSoHieuTau = 'BĐ-29283';
  String selectedChuyenBien = '1';
  DateTime? _startDate1;
  DateTime? _startDate2;


  Future<void> _selectStartDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _startDate1) {
      setState(() {
        _startDate1 = picked;
      });
    }
  }

  Future<void> _selectStartDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate2 ?? _startDate1 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _startDate2) {
      if (_startDate1 == null || picked.isAfter(_startDate1!)) {
        setState(() {
          _startDate2 = picked;
        });
      } else {
        // Handle the case where the selected end date is earlier than the start date
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Lỗi'),
              content: Text('Ngày kết thúc không thể trước ngày bắt đầu.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Theo dõi hải trình',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenSize.height * 0.035),
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/bg.png',
                      width: screenSize.height * 0.04,
                      height: screenSize.height * 0.035,
                    ),
                  ],
                ),
                SizedBox(
                  width: screenSize.height * 0.02,
                ),
                Column(
                  children: [
                    Text(
                      "Số hiệu tàu",
                      style: TextStyle(fontSize: screenSize.width * 0.045),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.03),
                      child: CustomDropdown(
                        items: ['BĐ-29283', 'TÀU-12345', 'ABC-98765'],
                        selectedValue: selectedSoHieuTau,
                        onChanged: (String value) {
                          setState(() {
                            selectedSoHieuTau = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.1, top: screenSize.width * 0.036),
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/location.png',
                      width: screenSize.width * 0.05,
                      height: screenSize.width * 0.055,
                      color: Colors.green,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Ngày bắt đầu",
                      style: TextStyle(fontSize: screenSize.width * 0.045),
                    )
                  ],
                ),
                SizedBox(
                  width: screenSize.width * 0.13,
                ),
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/location.png',
                      width: screenSize.width * 0.05,
                      height: screenSize.width * 0.055,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Ngày kết thúc",
                      style: TextStyle(fontSize: screenSize.width * 0.045),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.07, top: screenSize.width * 0.040),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: _startDate1 == null
                            ? Padding(
                          padding: EdgeInsets.only(left: screenSize.width *
                              0.02),
                          child: Text(
                            'Chọn ngày',
                            style: TextStyle(fontSize: screenSize.width * 0.035,
                                color: Colors.black),
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '${_startDate1!.day}/${_startDate1!
                                .month}/${_startDate1!.year} ',
                            style: TextStyle(fontSize: screenSize.width * 0.035),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectStartDate1(context),
                        child: Icon(Icons.arrow_drop_down,
                            size: screenSize.width * 0.08, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenSize.width * 0.07),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: _startDate2 == null
                            ? Padding(
                          padding: EdgeInsets.only(left: screenSize.height *
                              0.02),
                          child: Text(
                            'Chọn ngày',
                            style: TextStyle(fontSize: screenSize.width * 0.035,
                                color: Colors.black),
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.only(left: screenSize.width *
                              0.04),
                          child: Text(
                            '${_startDate2!.day}/${_startDate2!
                                .month}/${_startDate2!.year} ',
                            style: TextStyle(fontSize: screenSize.width * 0.035),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectStartDate2(context),
                        child: Icon(Icons.arrow_drop_down,
                            size: screenSize.width * 0.08, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.35, top: screenSize.width * 0.05),
            child: Row(
              children: [
                Column(
                  children: [
                    MyButton(
                      onTap: () {
                        // Kiểm tra xem cả ngày bắt đầu và ngày kết thúc đã được chọn hay chưa
                        if (_startDate1 != null && _startDate2 != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thông tin tìm kiếm'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Ngày bắt đầu: ${_startDate1!
                                            .day}/${_startDate1!
                                            .month}/${_startDate1!.year}'),
                                    Text(
                                        'Ngày kết thúc: ${_startDate2!
                                            .day}/${_startDate2!
                                            .month}/${_startDate2!.year}'),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Lỗi'),
                                content: Text(
                                    'Vui lòng chọn cả ngày bắt đầu và ngày kết thúc.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      color: Colors.red,
                      text: "Tìm kiếm",
                      width: screenSize.width * 0.26,
                      height: screenSize.height * 0.045,
                      textStyle: TextStyle(fontSize: screenSize.width * 0.042,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(width: screenSize.width * 0.22,),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context, builder: (BuildContext context){
                              return AlertDialog(
                                insetPadding: EdgeInsets.all(25),
                                content: Container(
                                  width: 600.0,
                                  height: 900.0,
                                  child: Column(
                                    children: [
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('BĐ-92130-TS',style: TextStyle(
                                        color: Colors.red,fontSize: screenSize.width*0.05,fontWeight: FontWeight.bold
                                      ),),
                                      SizedBox(height: screenSize.height*0.02,),
                                        Text('14/01/2022---------------4444--------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      )
                                      ,SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      )
                                      ,SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      )
                                      ,SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      )
                                      ,SizedBox(height: screenSize.height*0.02,),
                                      Text('14/01/2022-----------------------------19`201N',style: TextStyle(wordSpacing: screenSize.width*0.07),),
                                      SizedBox(height: screenSize.height*0.02,),
                                      Container(
                                        height: 1,
                                        width: screenSize.width*0.7,
                                        color: Colors.black,
                                      )

                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                        });
                      },
                      child: Column(
                        children: [
                          Image.asset('lib/assets/images/menu_hi.png', width: screenSize.width*0.11,height: screenSize.height*0.05,)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              height: 510,
              child: PolylineMap(),
              ),
            ),
        ],
      ),
    );
  }
}
