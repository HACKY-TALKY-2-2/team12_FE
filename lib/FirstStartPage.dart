import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // main.dart import

class FirstStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD), // 배경색 설정
      body: SafeArea(child: FirstPage()),
    );
  }
}

class UserData {
  String phone = '';
  String age = '';
  String field = '';
  String role = '';
  String tenure = '';
  String company = '';
  String profile = '';
  final Set<String> personalities = {};
  final Set<String> interests = {};

  void showResults(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("입력한 정보"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("전화번호: $phone"),
                Text("나이: $age"),
                Text("분야: $field"),
                Text("직무: $role"),
                Text("연차: $tenure"),
                Text("재직중인 회사: $company"),
                Text("프로필 상세정보: $profile"),
                Text("성격: ${personalities.join(", ")}"),
                Text("관심사: ${interests.join(", ")}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _setFirstStartFalse(); // Set isFirstStart to false
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainPage()), // Navigate to MainPage
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _setFirstStartFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstStart', false);
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final userData = UserData();

  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final fieldController = TextEditingController();
  final roleController = TextEditingController();
  final tenureController = TextEditingController();
  final companyController = TextEditingController();
  final profileController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    ageController.dispose();
    fieldController.dispose();
    roleController.dispose();
    tenureController.dispose();
    companyController.dispose();
    profileController.dispose();
    super.dispose();
  }

  Future<void> _setFirstStartFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstStart', false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '회원 프로필',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '자신의 정보를 정확하게 작성해 주세요',
                              style: TextStyle(
                                color: Color(0xFF8A8BB1),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                SizedBox(height: 32),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: '핸드폰 번호',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: '나이',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: fieldController,
                    decoration: InputDecoration(
                      hintText: '분야',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: roleController,
                    decoration: InputDecoration(
                      hintText: '직무',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: tenureController,
                    decoration: InputDecoration(
                      hintText: '연차',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 40.0, // 높이를 40으로 설정
                  child: TextField(
                    controller: companyController,
                    decoration: InputDecoration(
                      hintText: '재직중인 회사',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 160.0, // 10줄짜리 텍스트를 위한 대략적인 높이
                  child: TextFormField(
                    controller: profileController,
                    maxLines: 10, // 최대 10줄까지 표시
                    keyboardType:
                        TextInputType.multiline, // 여러 줄 입력을 위한 키보드 타입 설정
                    decoration: InputDecoration(
                      hintText: '프로필 상세 정보', // 힌트 텍스트 설정
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBFC0C7)), // 테두리 색상
                        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAFBFD), // 배경 색상
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF615CEC), // 버튼 배경색 설정
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // 버튼 모서리 둥글게 설정
              ),
              minimumSize: Size(double.infinity, 49), // 버튼의 최소 크기 설정
            ),
            onPressed: () {
              updateUserData();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SecondPage(userData: userData),
                ),
              );
            },
            child: Text(
              "다음",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // 글자색 설정
              ),
            ),
          ),
        ),
      ],
    );
  }

  void updateUserData() {
    userData.phone = phoneController.text;
    userData.age = ageController.text;
    userData.field = fieldController.text;
    userData.role = roleController.text;
    userData.tenure = tenureController.text;
    userData.company = companyController.text;
    userData.profile = profileController.text;
  }
}

class SecondPage extends StatefulWidget {
  final UserData userData;

  SecondPage({required this.userData});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<String> options = [
    "대화를 잘 이끌어주는 사람",
    "따뜻한 위로가 되는 사람",
    "논리적으로 팩트를 제시하는 사람",
    "친절하게 설명을 잘 해주는 사람",
    "전문성이 느껴지는 사람"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '희망하는 파트너 성향',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '자신의 정보를 정확하게 작성해 주세요',
                                  style: TextStyle(
                                    color: Color(0xFF8A8BB1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    SizedBox(height: 32),
                    ...options
                        .map((option) => ListTile(
                              title: Text(option),
                              onTap: () {
                                setState(() {
                                  if (widget.userData.personalities
                                      .contains(option)) {
                                    widget.userData.personalities
                                        .remove(option);
                                  } else if (widget
                                          .userData.personalities.length <
                                      3) {
                                    widget.userData.personalities.add(option);
                                  }
                                  // 3개 이상 선택 방지
                                });
                              },
                              leading: Icon(
                                Icons.favorite,
                                color: widget.userData.personalities
                                        .contains(option)
                                    ? Colors.green
                                    : Colors.grey, // 선택 시 초록색, 아닐 시 회색
                              ),
                              // leading: Icon(
                              //   Icons.check_circle,
                              //   color: widget.userData.personalities
                              //           .contains(option)
                              //       ? Colors.green
                              //       : Colors.grey, // 선택 시 초록색, 아닐 시 회색
                              // ),
                              // trailing:
                              //     widget.userData.personalities.contains(option)
                              //         ? Icon(Icons.check, color: Colors.blue)
                              //         : null,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.userData.personalities.isEmpty
                      ? Color(0xFFB9BBE9) // 선택이 없을 때 색상
                      : Color(0xFF615CEC), // 선택이 있을 때 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 49),
                ),
                onPressed: widget.userData.personalities.isNotEmpty
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ThirdPage(userData: widget.userData),
                          ),
                        );
                      }
                    : null, // 버튼 비활성화
                child: Text(
                  "다음",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  final UserData userData;

  ThirdPage({required this.userData});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final List<String> options = [
    "이직 준비",
    "커리어 방향 설정",
    "업계 동향 파악",
    "창업 및 투자 조언",
    "해외 커리어 탐색",
    "공고 문의"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '희망하는 파트너 성향',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '자신의 정보를 정확하게 작성해 주세요',
                                  style: TextStyle(
                                    color: Color(0xFF8A8BB1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    SizedBox(height: 32),
                    ...options
                        .map((option) => ListTile(
                              title: Text(option),
                              onTap: () {
                                setState(() {
                                  if (widget.userData.interests
                                      .contains(option)) {
                                    widget.userData.interests.remove(option);
                                  } else if (widget.userData.interests.length <
                                      3) {
                                    widget.userData.interests.add(option);
                                  }
                                  // 3개 이상 선택 방지
                                });
                              },
                              leading: Icon(
                                Icons.favorite,
                                color:
                                    widget.userData.interests.contains(option)
                                        ? Colors.green
                                        : Colors.grey, // 선택 시 초록색, 아닐 시 회색
                              ),
                              // leading: Icon(
                              //   Icons.check_circle,
                              //   color: widget.userData.personalities
                              //           .contains(option)
                              //       ? Colors.green
                              //       : Colors.grey, // 선택 시 초록색, 아닐 시 회색
                              // ),
                              // trailing:
                              //     widget.userData.personalities.contains(option)
                              //         ? Icon(Icons.check, color: Colors.blue)
                              //         : null,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.userData.interests.isEmpty
                      ? Color(0xFFB9BBE9) // 선택이 없을 때 색상
                      : Color(0xFF615CEC), // 선택이 있을 때 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 49),
                ),
                onPressed: widget.userData.interests.isNotEmpty
                    ? () {
                        widget.userData.showResults(context);
                      }
                    : null, // 버튼 비활성화
                child: Text(
                  "완료",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('세 번째 페이지'),
    //   ),
    //   body: ListView(
    //     children: [
    //       ...options
    //           .map((option) => CheckboxListTile(
    //                 title: Text(option),
    //                 value: widget.userData.interests.contains(option),
    //                 onChanged: (bool? value) {
    //                   if (value == true) {
    //                     setState(() {
    //                       widget.userData.interests.add(option);
    //                       if (widget.userData.interests.length > 2) {
    //                         widget.userData.interests.remove(option);
    //                       }
    //                     });
    //                   } else {
    //                     setState(() {
    //                       widget.userData.interests.remove(option);
    //                     });
    //                   }
    //                 },
    //               ))
    //           .toList(),
    //       if (widget.userData.interests.isNotEmpty &&
    //           widget.userData.interests.length <= 2)
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 16.0),
    //           child: ElevatedButton(
    //             onPressed: () {
    //               widget.userData.showResults(context);
    //             },
    //             child: Text('완료'),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
  }
}
