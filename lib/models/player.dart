class Player {
  final String name;
  List<bool> chamber; // 플레이어의 탄창 상태
  int currentChamberIndex; // 현재 탄창 위치
  bool isGameOver; // 게임 종료 여부
  String result; // 결과 메시지

  Player({
    required this.name,
    required this.chamber,
    this.currentChamberIndex = 0,
    this.isGameOver = false,
    this.result = '',
  });
}
