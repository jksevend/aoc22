import 'utility/file_util.dart';

const String alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

void main(List<String> args) async {
  final String fileContent = await readFileContent('assets/3_rucksacks.txt');
  final List<String> fileLines = fileContent.split('\r\n');

  // Parse fileLines and add to rucksacks
  final List<Rucksack> rucksacks = [];
  for (var element in fileLines) {
    final int middle = element.length ~/ 2;
    final String firstCompartment = element.substring(0, middle);
    final String secondCompartment = element.substring(middle, element.length);

    final List<String> compartmentOne = extractCharacters(firstCompartment);
    final List<String> compartmentTwo = extractCharacters(secondCompartment);

    final Compartment first = Compartment(items: compartmentOne);
    final Compartment second = Compartment(items: compartmentTwo);

    final Rucksack rucksack =
        Rucksack(firstCompartment: first, secondCompartment: second);
    rucksacks.add(rucksack);
  }

  // Part 1 - Find matching items, get priority for item and accumulate
  int sum = 0;
  for (var rucksack in rucksacks) {
    final List<String> matchedChars = rucksack.findMatchingCharacters();
    for (var element in matchedChars) {
      final int priority = getPriority(element);
      sum += priority;
    }
  }
  print(sum);

  // Part 2 -
}

class Rucksack {
  final Compartment firstCompartment;
  final Compartment secondCompartment;

  const Rucksack({
    required this.firstCompartment,
    required this.secondCompartment,
  });

  List<String> findMatchingCharacters() {
    final List<String> first = firstCompartment.items;
    final List<String> second = secondCompartment.items;

    final List<String> result = [];
    for (var element in first) {
      // Prevent the same character being in result more than once
      if (second.contains(element) && !result.contains(element)) {
        result.add(element);
      }
    }
    return result;
  }
}

class Compartment {
  final List<String> items;

  const Compartment({required this.items});
}

List<String> extractCharacters(String source) {
  final List<String> chars = [];
  for (var element in source.runes) {
    final String character = String.fromCharCode(element);
    chars.add(character);
  }
  return chars;
}

int getPriority(String character) {
  int index = alphabet.indexOf(character) + 1;
  return index;
}