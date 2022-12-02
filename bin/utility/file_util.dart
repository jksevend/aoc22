import 'dart:io';

Future<String> readFileContent(final String path) async {
  final File file = File(path);
  return await file.readAsString();
}
