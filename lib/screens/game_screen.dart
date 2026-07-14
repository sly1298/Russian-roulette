import 'package:flutter/material.dart';
import '../models/player.dart';
import '../utils/random_generator.dart';
import '../widgets/revolver_chamber.dart';
import '../widgets/reset_overlay.dart'; // 리셋 애니메이션 오버레이
import 'package:audioplayers/audioplayers.dart'; // 사운드 재생 패키지

class GameScreen extends StatefulWidget {
  final List<String> playerNames;

  GameScreen({required this.playerNames});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<Player> players;
  bool isResetting = false; // 리셋 상태
  bool isFiring = false; // 격발 상태
  final AudioPlayer _audioPlayer = AudioPlayer(); // 오디오 플레이어 인스턴스 생성

  @override
  void initState() {
    super.initState();
    _initializePlayers();
  }

  void _initializePlayers() {
    players = widget.playerNames.map((name) {
      List<bool> chamber = List.filled(6, false);
      int bulletIndex = RandomGenerator.generateRandomIndex(6);
      chamber[bulletIndex] = true;
      return Player(name: name, chamber: chamber);
    }).toList();
  }

  Future<void> fireGun(Player player) async {
    if (isFiring || player.isGameOver) return;

    setState(() {
      isFiring = true;
    });

    print("fireGun called for ${player.name}"); // 디버그 로그

    bool isBullet = player.chamber[player.currentChamberIndex];

    try {
      // 사운드 재생
      await _audioPlayer.play(
        AssetSource(isBullet ? 'audio/리볼버 격발.mp3' : 'audio/리볼버 미격발.mp3'),
      );
    } catch (e) {
      print("Audio playback error: $e");
    }

    // 2.5초 뒤에 색깔 업데이트
    Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        player.result = isBullet ? '${player.name} 사망!' : '${player.name} 생존!';
        player.isGameOver = isBullet;
        player.currentChamberIndex++;
        isFiring = false;
      });
    });
  }

  void resetGame() {
    // 리볼버 재장전 사운드 재생
    try {
      _audioPlayer.play(AssetSource('audio/리볼버 재장전.mp3'));
    } catch (e) {
      print("Audio playback error: $e");
    }

    // 애니메이션 지연 시작 (500ms 딜레이)
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isResetting = true;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        for (var player in players) {
          player.chamber = List.filled(6, false);
          int bulletIndex = RandomGenerator.generateRandomIndex(6);
          player.chamber[bulletIndex] = true;
          player.currentChamberIndex = 0;
          player.isGameOver = false;
          player.result = '';
        }
        isResetting = false;
      });
    });
  }

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
      body: Stack(
        children: [
          // 기존 UI
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          '${index + 1}. ${player.name}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: RevolverChamber(
                          chamber: player.chamber,
                          currentChamberIndex: player.currentChamberIndex,
                        ),
                        trailing: ElevatedButton(
                          onPressed: player.isGameOver ? null : () => fireGun(player),
                          child: Text('격발'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('리셋'),
              ),
            ],
          ),

          // 리셋 애니메이션
          if (isResetting)
            ResetOverlay(), // 오버레이 위젯
        ],
      ),
    );
  }
}
