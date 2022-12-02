import 'utility/file_util.dart';

const int losePoints = 0;
const int drawPoints = 3;
const int winPoints = 6;

void main(List<String> args) async {
  final String fileContent =
      await readFileContent('assets/2_strategy_guide.txt');
  final List<String> fileLines = fileContent.split('\n');

  final List<Round> rounds = fileLines.map((line) {
    final List<String> hands = line.split(' ');
    final OpponentLetter opponentLetter =
        OpponentLetter.values.byName(hands[0].trimRight());
    final MyLetter myLetter = MyLetter.values.byName(hands[1].trimRight());
    return Round(opponentLetter: opponentLetter, myLetter: myLetter);
  }).toList();

  final List<int> scores = [];
  for (var round in rounds) {
    final int score = round.calculateMyScore();
    scores.add(score);
  }

  int scoreSum = 0;
  for (var score in scores) {
    scoreSum += score;
  }
  print(scoreSum);
}

enum OpponentLetter {
  A,
  B,
  C;
}

enum MyLetter {
  X(1),
  Y(2),
  Z(3);

  final int pointValue;
  const MyLetter(this.pointValue);
}

class Round {
  final OpponentLetter opponentLetter;
  final MyLetter myLetter;

  Round({required this.opponentLetter, required this.myLetter});

  int calculateMyScore() {
    int myValue = myLetter.pointValue;

    if (isDraw(opponentLetter, myLetter)) {
      myValue += drawPoints;
    } else if (didWin(opponentLetter, myLetter)) {
      myValue += winPoints;
    } else {
      myValue += losePoints;
    }

    return myValue;
  }
}

bool isDraw(OpponentLetter opponentLetter, MyLetter myLetter) {
  return (opponentLetter == OpponentLetter.A && myLetter == MyLetter.X) ||
      (opponentLetter == OpponentLetter.B && myLetter == MyLetter.Y) ||
      (opponentLetter == OpponentLetter.C && myLetter == MyLetter.Z);
}

bool didWin(OpponentLetter opponentLetter, MyLetter myLetter) {
  return (opponentLetter == OpponentLetter.A && myLetter == MyLetter.Y) ||
      (opponentLetter == OpponentLetter.B && myLetter == MyLetter.Z) ||
      (opponentLetter == OpponentLetter.C && myLetter == MyLetter.X);
}
