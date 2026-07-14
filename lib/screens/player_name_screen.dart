import 'package:flutter/material.dart';
import 'game_screen.dart';

class PlayerNameScreen extends StatefulWidget {
  // Dart에서 final 키워드는 변수의 값을 한 번 설정하면 변경할 수 없음을 보장
  /** 예시
   *
      final int value1 = calculateValue(); // 런타임에서 값을 계산
      const int value2 = 10; // 컴파일 타임 상수
   */

  final int playerCount;

  PlayerNameScreen({required this.playerCount});

  @override
  _PlayerNameScreenState createState() => _PlayerNameScreenState();
}

class _PlayerNameScreenState extends State<PlayerNameScreen> {
  late List<TextEditingController> controllers;

  //override란? 기존에 정의되어있는 메소드를 내가 재정의해서 사용할때 구분하기위해 사용(가독성을 위해)
  //void를 사용하는 이유는 반환을 하지않는다!! (단지 특정 동작을 수행한다고 생각하면 편할듯)
  @override
  void initState() {
    //재정의된 매서드에서 부모 클래스의 초기화를 반드시 호출 해야하기 때문에 super 사용 [정의된 매서드를 수정해서 사용(@override)하는데 정의된 매서드를 반드시 호출해야하는것을 권장하기에 사용]
    super.initState();
    //controllers 는 화면에서 사용하는 입력 필드와 연결된 컨트롤러 리스트
    controllers = List.generate(
      widget.playerCount,
          (index) => TextEditingController(),
      /** 만약 플레이어가 3명이라면 이런식으로 만들어질꺼임
       * controllers = [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          ];

       */
    );
  }//

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void startGame() {
    List<String> playerNames =
    controllers.map((controller) => controller.text).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(playerNames: playerNames),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '사용자 이름 입력',
          style: TextStyle(
            color: Colors.white, // 글자 색상을 하얀색으로 설정
          ),
        ),
        backgroundColor: Colors.black, // AppBar 배경색 검정
        iconTheme: IconThemeData(color: Colors.white), // 뒤로 가기 버튼 등 아이콘 색상 변경
      ),
      body: ListView.builder(
        itemCount: widget.playerCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controllers[index],
              decoration: InputDecoration(
                labelText: '사용자 ${index + 1} 이름',
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controllers.every((controller) => controller.text.isNotEmpty)) {
            startGame();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('사용자 이름을 입력해주세요')),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
