import 'utility/file_util.dart';
import 'utility/stack.dart';

void main() async {
  final String fileContent = await readFileContent('assets/5_supply_stacks.txt');
  final List<String> fileLines = fileContent.split('\r\n');

  final List<Move> moves = [];
  for (var line in fileLines) {
    final List<String> parts = line.split(' ');
    final Move move = Move(int.parse(parts[1]), int.parse(parts[3]), int.parse(parts[5]));
    moves.add(move);
  }

  final Crane crane = Crane();
  for (var move in moves) {
    crane.applyMove(move);
  }

  final String result = crane.parseWord();
  print(result);
}

class Crane {
  Map<int, Stack<String>> stacks = {
    1: Stack<String>.from(['B', 'P', 'N', 'Q', 'H', 'D', 'R', 'T']),
    2: Stack<String>.from(['W', 'G', 'T', 'J', 'B', 'V']),
    3: Stack<String>.from(['N', 'R', 'H', 'D', 'S', 'V', 'M', 'Q']),
    4: Stack<String>.from(['P', 'Z', 'N', 'M', 'C']),
    5: Stack<String>.from(['D', 'Z', 'B']),
    6: Stack<String>.from(['V', 'C', 'W', 'Z']),
    7: Stack<String>.from(['G', 'Z', 'N', 'C', 'V', 'Q', 'L', 'S']),
    8: Stack<String>.from(['L', 'G', 'J', 'M', 'D', 'N', 'V']),
    9: Stack<String>.from(['T', 'P', 'M', 'F', 'Z', 'C', 'G']),
  };

  Crane();

  void applyMove(Move move) {
    if (move.amount == 1) {
      final String value = stacks[move.from]!.pop();
      stacks[move.to]!.push(value);
    } else {
      final List<String> checkpoint = [];
      for (int i = 0; i < move.amount; i++) {
        final String value = stacks[move.from]!.pop();
        checkpoint.add(value);
      }

      final List<String> toPut = checkpoint.reversed.toList();
      for (var elem in toPut) {
        stacks[move.to]!.push(elem);
      }
    }
  }

  String parseWord() {
    String result = '';
    for (var element in stacks.values) {
      result += element.peek;
    }

    return result;
  }
}

class Move {
  int amount;
  int from;
  int to;

  Move(this.amount, this.from, this.to);
}
