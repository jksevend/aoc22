import 'dart:math';

import 'utility/file_util.dart';

void main() async {
  final String fileContent = await readFileContent('assets/4_camp_cleanup.txt');
  final List<String> fileLines = fileContent.split('\r\n');

  final List<AssignmentPair> pairs = [];
  for (var line in fileLines) {
    final List<String> parsed = line.split(',');
    final AssignmentPair assignmentPair = AssignmentPair(parsed[0], parsed[1]);
    pairs.add(assignmentPair);
  }

  int count = 0;
  for (var pair in pairs) {
    if (pair.fullyContained()) {
      count++;
    }
  }

  print(count);
}

class AssignmentPair {
  final String first;
  final String second;

  const AssignmentPair(this.first, this.second);

  int get maxSectionNumber {
    final List<String> numbersOne = first.split('-');
    final List<String> numbersTwo = second.split('-');

    final List<int> numbers = [
      int.parse(numbersOne[0]),
      int.parse(numbersOne[1]),
      int.parse(numbersTwo[0]),
      int.parse(numbersTwo[1]),
    ];

    return numbers.reduce(max);
  }

  List<int> get firstSection {
    final List<String> numbers = first.split('-');
    return _parseSection(numbers);
  }

  List<int> get secondSection {
    final List<String> numbers = second.split('-');
    return _parseSection(numbers);
  }

  List<int> _parseSection(List<String> numbers) {
    final int from = int.parse(numbers[0]);
    final int to = int.parse(numbers[1]);

    final List<int> result = [];
    for (int i = from; i <= to; i++) {
      result.add(i);
    }

    return result;
  }

  bool fullyContained() {
    final List<int> first = firstSection;
    final List<int> second = secondSection;

    return first.toSet().containsAll(second) || second.toSet().containsAll(first) || overlaps();
  }

  bool overlaps() {
    final List<int> first = firstSection;
    final List<int> second = secondSection;

    return second.contains(first.first) || second.contains(first.last);
  }
}
