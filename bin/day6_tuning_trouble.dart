import 'utility/file_util.dart';

const int markerLength = 14;

void main() async {
  final String fileContent =
      await readFileContent('assets/day6_tuning_trouble.txt');

  final List<String> fileChars = fileContent.split('');
  int processed = 0;

  for (int i = 0; i < fileChars.length; i++) {
    final List<String> currentMarker = fileChars.sublist(i, i + markerLength);
    final List<String> uniqueMarker = currentMarker.toSet().toList();

    if (uniqueMarker.length == markerLength) {
      processed = i + markerLength;
      break;
    }
  }

  print(processed);
}
