import 'package:collection/collection.dart';

import 'utility/file_util.dart';

const String alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

void main(List<String> args) async {
  final String fileContent = await readFileContent('assets/day3_rucksacks.txt');
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
  final List<List<Rucksack>> rucksackGroups = rucksacks.slices(3).toList();

  int sumTwo = 0;
  for (var group in rucksackGroups) {
    final String badgeItem = findBadgeItem(group);
    final int priority = getPriority(badgeItem);
    sumTwo += priority;
  }

  print(sumTwo);
}

class Rucksack {
  final Compartment firstCompartment;
  final Compartment secondCompartment;

  const Rucksack({
    required this.firstCompartment,
    required this.secondCompartment,
  });

  List<String> getFullCompartment() {
    return List.from(firstCompartment.items + secondCompartment.items);
  }

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
  if (index == -1) {
    return 0;
  }
  return index;
}

String findBadgeItem(final List<Rucksack> group) {
  final List<String> first = group.first.getFullCompartment();
  final List<String> second = group[1].getFullCompartment();
  final List<String> third = group[2].getFullCompartment();

  final List<String> result = [];
  for (var character in first) {
    if (second.contains(character) &&
        third.contains(character) &&
        !result.contains(character)) {
      result.add(character);
    }
  }
  return result[0];
}
