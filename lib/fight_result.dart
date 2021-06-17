class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._("Won");
  static const lost = FightResult._("Lost");
  static const draw = FightResult._("Draw");

  static FightResult? calculateResults(final int yourLives, final int enemysLives) {
    if (yourLives == 0 && enemysLives == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLives == 0) {
      return won;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return 'FightResult{result: $result}';
  }

  static FightResult? from(String result) {
    switch (result) {
      case "Won":
        return won;
      case "Lost":
        return lost;
      case "Draw":
        return draw;
      default:
        return null;
    }
  }
}
