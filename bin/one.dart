import 'dart:math';

import 'utility/file_util.dart';

void main(List<String> args) async {
  // Read file content and split
  final String fileContent = await readFileContent('assets/1_elvs.txt');
  final List<String> fileLines = fileContent.split('\r\n');

  final List<List<String>> parsedContent = [];
  final List<String> elvContent = [];

  for (var i = 0; i < fileLines.length; i++) {
    if (fileLines[i] == '') {
      parsedContent.add(List.from(elvContent));
      elvContent.clear();
    } else {
      elvContent.add(fileLines[i]);
    }
  }
  // Map every string entry to an elv class
  final List<Elv> elvs = parsedContent
      .map((elvList) => Elv(
          food: elvList
              .map((caloriesValue) => int.parse(caloriesValue))
              .toList()))
      .toList();

  final List<int> sums = elvs.map((elv) => elv.sum).toList();
  print(sums.reduce(max));
}

class Elv {
  final List<int> food;

  Elv({required this.food});

  int get sum {
    int sum = 0;
    for (var element in food) {
      sum += element;
    }
    return sum;
  }
}
