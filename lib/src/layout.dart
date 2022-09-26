import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  var data;

  @override
  void initState() {
    // TODO: implement initState
    lottoTotalResult();
    super.initState();
  }

  lottoTotalResult() async {
    String date = "20220924";
    int _lottoDrwNo = 1034;

    var _toDay = DateTime.now();
    int difference =
        int.parse(_toDay.difference(DateTime.parse(date)).inDays.toString());

    _lottoDrwNo = _lottoDrwNo + (difference ~/ 7);

    print(difference);
    print(difference ~/ 7);
    print(_lottoDrwNo);

    var url = Uri.parse(
        "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${_lottoDrwNo}");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      _lottoDrwNo = (_lottoDrwNo - 1);

      var url = Uri.parse(
          "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${_lottoDrwNo}");
      http.Response response = await http.get(url);

      setState(() {
        data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (data == null)
        ? Container()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '${data['drwNo']} 회차 / 추첨일 : ${data['drwNoDate']}',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget),
                    );
                  },
                  icon: Icon(Icons.refresh),
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 1,
              shape: CircularNotchedRectangle(),
              notchMargin: 7,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey[400],
                selectedItemColor: Colors.blueGrey[800],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                // onTap: onSelectItem,
                currentIndex: 0,
                elevation: 2,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.font_download),
                    label: '폰트',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.brush),
                    label: '폰트색상',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera),
                    label: '앨범',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                        CupertinoIcons.rectangle_fill_on_rectangle_angled_fill),
                    label: '백그라운드색상',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.save_alt),
                    label: '저장',
                  ),
                ],
              ),
            ),
          );
  }
}
