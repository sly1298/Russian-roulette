import 'package:flutter/material.dart';
import 'player_name_screen.dart';

class PlayerCountScreen extends StatefulWidget {
  @override
  _PlayerCountScreenState createState() => _PlayerCountScreenState();
}

class _PlayerCountScreenState extends State<PlayerCountScreen> {
  int playerCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '러시안 룰렛',
          style: TextStyle(
            color: Colors.white, // 글자 색상을 하얀색으로 설정
          ),
        ),
        backgroundColor: Colors.black, // AppBar 배경색 검정
        iconTheme: IconThemeData(color: Colors.white), // 뒤로 가기 버튼 등 아이콘 색상 변경
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '인원 수 입력:',
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                onChanged: (value) {
                  setState(() {
                    playerCount = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: playerCount > 0
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayerNameScreen(playerCount: playerCount),
                  ),
                );
              }
                  : null,
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
