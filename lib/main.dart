import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FirstStartPage.dart';
import 'alarm.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  final prefs = await SharedPreferences.getInstance();
  // final isFirstStart = prefs.getBool('isFirstStart') ??
  //     true; // Get isFirstStart value, default to true
  final isFirstStart = true;

  runApp(MyApp(isFirstStart: isFirstStart));
}

class MyApp extends StatelessWidget {
  final bool isFirstStart;

  MyApp({required this.isFirstStart});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: isFirstStart
          ? FirstStartPage()
          : MainPage(), // Show FirstStartPage or MainPage based on isFirstStart
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  int toggleValue = 0; // 토글의 현재 위치를 저장합니다.
  int selectedChip = 0; // 아무것도 선택되지 않았을 때는 -1
  final List<String> chipLabels = [
    'IT',
    '인사',
    '품질관리',
    '마케팅',
    '회계',
    '취직',
    '재무관리',
    '응용통계',
  ];
  final List<String> items = [
    'IT',
    '인사',
    '품질관리',
    '마케팅',
    '회계',
    '취직',
    '재무관리',
    '응용통계',
  ];

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("알림"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("닫기"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPostDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String title = '';
    String startLocation = '';
    String endLocation = '';
    String details = '';
    int mentorMenteeToggle = 0;
    int carpoolTaxiToggle = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "게시글 등록",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          shape: RoundedRectangleBorder(
            // 모서리 둥글게
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10), // 여기서 조정합니다
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Divider(color: Color(0xFFE1E1E1)),
                      SizedBox(height: 10),
                      CustomToggleSwitch(
                        height: 30,
                        borderRadius: 15,
                        backgroundColor: Colors.grey,
                        options: ['멘토', '멘티'],
                        toggleValue: mentorMenteeToggle,
                        onChanged: (index) {
                          setState(() {
                            mentorMenteeToggle = index;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CustomToggleSwitch(
                        height: 30,
                        borderRadius: 15,
                        backgroundColor: Colors.grey,
                        options: ['카풀', '택시'],
                        toggleValue: carpoolTaxiToggle,
                        onChanged: (index) {
                          setState(() {
                            carpoolTaxiToggle = index;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      buildTextField('게시글 제목', title),
                      buildTextField('출발지', startLocation),
                      buildTextField('도착지', endLocation),
                      buildTextField('상세내용', details),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // 여기에 등록 로직 추가
                                // 예: 서버에 데이터 전송 등
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("등록 내용 확인"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text("제목: $title"),
                                          Text("출발지: $startLocation"),
                                          Text("도착지: $endLocation"),
                                          Text("상세내용: $details"),
                                          Text(
                                              "멘토/멘티: ${mentorMenteeToggle == 0 ? "멘토" : "멘티"}"),
                                          Text(
                                              "카풀/택시: ${carpoolTaxiToggle == 0 ? "카풀" : "택시"}"),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("닫기"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF5521EB), // 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 라운드 모서리
                              ),
                              minimumSize: Size(120, 40), // 너비와 높이
                            ),
                            child: Text('등록'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFAFBFD), // 배경색
                              side:
                                  BorderSide(color: Color(0xFF5521EB)), // 보더 색상
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 라운드 모서리
                              ),
                              minimumSize: Size(120, 40), // 너비와 높이
                            ),
                            child: Text(
                              '닫기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF5521EB), // 글씨색
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildTextField(String label, String value) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBFC0C7)),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
        onSaved: (newValue) {
          // Update the value
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '경로 검색',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '이동하실 경로를 검색해 주세요',
                          style: TextStyle(
                            color: Color(0xFF8A8BB1),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => alarmPage()), // AlarmPage로 이동
                      );
                    },
                    // showPopup("알림입니다"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getInt('userAppCode') ?? '없음';
                      showPopup("User ID: $userId");
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30.0, // Container의 높이를 30.0으로 고정
                          child: TextField(
                            controller: startController,
                            decoration: InputDecoration(
                              hintText: '출발지',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                            ),
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 30.0, // Container의 높이를 30.0으로 고정
                          child: TextField(
                            controller: endController,
                            decoration: InputDecoration(
                              hintText: '도착지',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                            ),
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // 검색 기능 구현
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFAFBFD), // 배경색
                      side: BorderSide(color: Color(0xFF615CEC)), // 보더 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // 라운드 모서리
                      ),
                      minimumSize: Size(79, 70), // 너비와 높이
                    ),
                    child: Text(
                      '검색',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF615CEC), // 글씨색
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 3-way toggle switch widget
                      CustomToggleSwitch(
                        height: 30,
                        borderRadius: 15,
                        backgroundColor: Color(0xFFB9BBE9),
                        options: ['전체', '멘토', '멘티'],
                        toggleValue: toggleValue,
                        onChanged: (value) {
                          setState(() {
                            toggleValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 16),
              Container(
                height: 32.0, // 원하는 높이로 설정
                child: ListView.builder(
                  padding: EdgeInsets.zero, // ListView의 패딩을 제거합니다.
                  scrollDirection: Axis.horizontal,
                  itemCount: chipLabels.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedChip == index;
                    return GestureDetector(
                      onTap: () {
                        if (!isSelected) {
                          // 이미 선택된 상태가 아닐 때만 상태 업데이트
                          setState(() {
                            selectedChip = index;
                          });
                        }
                      },
                      child: Container(
                        // Container의 높이를 지정합니다.
                        height: 32.0, // 원하는 높이로 설정
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0), // 컨테이너 내부의 좌우 패딩
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.0), // 컨테이너 외부의 좌우 마진
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey
                                    .withOpacity(0.5), // 선택되지 않았을 때의 테두리 색상
                          ),
                        ),
                        child: Text(
                          chipLabels[index],
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: items.length, // 데이터 리스트의 아이템 개수
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(5), // 컨테이너의 마진값
                        padding: EdgeInsets.all(5), // 컨테이너의 패딩값
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8), // 이미지 모서리 둥글기
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5TulwreiAilalNuCPYfWqf1uaFawcRHBSgekfTY-WMC3hCz449Gq3Tnnl08SikllFBXE&usqp=CAU'), // 네트워크 이미지
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '타이틀', // 타이틀
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '서브 타이틀', // 서브 타이틀
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF8A8BB1),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFD600), // 배경색
                                      borderRadius:
                                          BorderRadius.circular(8), // 모서리 둥글기
                                    ),
                                    child: Text(
                                      '멘토', // 멘토 혹은 멘티
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF615CEC), // 버튼 배경색 설정
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // 버튼 모서리 둥글게 설정
                    ),
                    minimumSize: Size(double.infinity, 49), // 버튼의 최소 크기 설정
                  ),
                  onPressed: () {
                    showPostDialog(context);
                  },
                  child: Text(
                    "게시글 등록",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // 글자색 설정
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CustomToggleSwitch 클래스를 수정하여, 옵션 개수와 옵션 이름을 지정할 수 있도록 함
class CustomToggleSwitch extends StatelessWidget {
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final List<String> options;
  final int toggleValue;
  final Function(int) onChanged;

  CustomToggleSwitch({
    required this.height,
    required this.borderRadius,
    required this.backgroundColor,
    required this.options,
    required this.toggleValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFB9BBE9), // 수정됨: 배경색을 흰색으로 설정
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options.asMap().entries.map((entry) {
          int idx = entry.key;
          String val = entry.value;
          bool isSelected = toggleValue == idx;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(idx),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF615CEC) : Color(0xFFB9BBE9),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                alignment: Alignment.center,
                child: Text(
                  val,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
