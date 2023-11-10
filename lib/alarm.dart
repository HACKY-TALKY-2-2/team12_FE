import 'package:flutter/material.dart';

class alarmPage extends StatefulWidget {
  @override
  _alarmPageState createState() => _alarmPageState();
}

class _alarmPageState extends State<alarmPage> {
  List<bool> isHeartPressed = List.generate(5, (index) => false);
  int selectedIndex = 0; // 현재 선택된 인덱스
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 선택지를 가로로 나열
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text(
                '알림 메시지',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                '알림 현황을 확인해 주세요',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: CustomToggleSwitch(
                height: 30,
                borderRadius: 15,
                backgroundColor: Color(0xFFB9BBE9),
                options: ['교류 현황', '받은 요청', '보낸 요청'],
                toggleValue: selectedIndex,
                onChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // 선택된 선택지에 따라 다른 리스트뷰 표시
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  buildListView('교류 현황'),
                  buildListView('받은 요청'),
                  buildListView('보낸 요청'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 선택지 버튼 생성
  Widget buildChoiceButton(int index, String text) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Text(text),
      ),
    );
  }

  // 리스트뷰 생성
  Widget buildListView(String text) {
    return ListView.builder(
      itemCount: items.length, // 데이터 리스트의 아이템 개수
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            width: 44,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5TulwreiAilalNuCPYfWqf1uaFawcRHBSgekfTY-WMC3hCz449Gq3Tnnl08SikllFBXE&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$text 타이틀', // 타이틀
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
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
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
          trailing: text == "교류 현황"
              ? ElevatedButton(
                  onPressed: () {
                    showReviewPopup(context, '$text 아이템 $index');
                  },
                  child: Text('리뷰 작성'),
                )
              : null,
        );
      },
    );
  }

  void showReviewPopup(BuildContext context, String item) {
    List<String> reviewCategories = [
      '카테고리 1',
      '카테고리 2',
      '카테고리 3',
      '카테고리 4',
      '카테고리 5'
    ];
    TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '리뷰 작성',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              for (int i = 0; i < reviewCategories.length; i++)
                buildReviewCategoryItem(reviewCategories[i], i),
              SizedBox(height: 200.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('매우 좋아요', () {
                    // 버튼 1이 눌렸을 때의 동작
                  }),
                  buildButton('좋아요', () {
                    // 버튼 2가 눌렸을 때의 동작
                  }),
                  buildButton('보통이에요', () {
                    // 버튼 3이 눌렸을 때의 동작
                  }),
                  buildButton('아쉬워요', () {
                    // 버튼 4가 눌렸을 때의 동작
                  }),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // 여기에 리뷰를 서버에 전송하는 등의 동작을 추가할 수 있습니다.
                String review = reviewController.text;
                print('리뷰 내용: $review');
                Navigator.pop(context); // 팝업을 닫기
              },
              child: Text('리뷰 작성'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 팝업을 닫기
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  void showDetailPopup(BuildContext context, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('상세 정보'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('선택된 아이템: $item'),
              // 여기에 추가적인 상세 정보 표시를 원하는 대로 구현할 수 있습니다.
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 팝업을 닫기
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  Widget buildReviewCategoryItem(String category, int index) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isHeartPressed[index] = !isHeartPressed[index];
            });
          },
          child: Icon(
            isHeartPressed[index] ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
        SizedBox(width: 8.0),
        Text(category),
      ],
    );
  }
}

Widget buildButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(text),
  );
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
        color: backgroundColor,
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
                  color: isSelected ? Color(0xFF615CEC) : Colors.transparent,
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
