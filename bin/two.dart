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
    final int score = round.calculateMyScorePartOne();
    scores.add(score);
  }

  final List<int> scoresTwo = [];
  for (var round in rounds) {
    final int score = round.calculcateMyScorePartTwo();
    scoresTwo.add(score);
  }

  int scoreSum = 0;
  for (var score in scores) {
    scoreSum += score;
  }

  int scoreSumTwo = 0;
  for (var score in scoresTwo) {
    scoreSumTwo += score;
  }

  print(scoreSum);
  print(scoreSumTwo);
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

  int calculateMyScorePartOne() {
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

  int calculcateMyScorePartTwo() {
    int myValue = 0;
    switch (myLetter) {
      case MyLetter.X:
        MyLetter letterToPlay = _doLose();
        myValue += letterToPlay.pointValue;
        myValue += losePoints;
        break;
      case MyLetter.Y:
        MyLetter letterToPlay = _doDraw();
        myValue += letterToPlay.pointValue;
        myValue += drawPoints;
        break;
      case MyLetter.Z:
        MyLetter letterToPlay = _doWin();
        myValue += letterToPlay.pointValue;
        myValue += winPoints;
        break;
      default:
        throw StateError('Invalid letter');
    }
    return myValue;
  }

  MyLetter _doLose() {
    switch (opponentLetter) {
      case OpponentLetter.A:
        return MyLetter.Z;
      case OpponentLetter.B:
        return MyLetter.X;
      case OpponentLetter.C:
        return MyLetter.Y;
      default:
        throw StateError('Invalid letter');
    }
  }

  MyLetter _doWin() {
    switch (opponentLetter) {
      case OpponentLetter.A:
        return MyLetter.Y;
      case OpponentLetter.B:
        return MyLetter.Z;
      case OpponentLetter.C:
        return MyLetter.X;
      default:
        throw StateError('Invalid letter');
    }
  }

  MyLetter _doDraw() {
    switch (opponentLetter) {
      case OpponentLetter.A:
        return MyLetter.X;
      case OpponentLetter.B:
        return MyLetter.Y;
      case OpponentLetter.C:
        return MyLetter.Z;
      default:
        throw StateError('Invalid letter');
    }
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
