import 'dart:convert';
import 'dart:io';

File loadFixture(String path) => File(
      '${Directory.current.path}/test/fixtures/data/$path',
    );

String loadFixtureAsString(String path) {
  final file = loadFixture(path);
  return file.readAsStringSync();
}

Map<String, dynamic> loadFixtureFromJsonFile(String path) {
  final jsonString = loadFixtureAsString(path);
  return json.decode(jsonString) as Map<String, dynamic>;
}

List<Map<String, dynamic>> loadFixtureFromJsonFileAsList(String path) {
  final jsonString = loadFixtureAsString(path);
  return List.from(json.decode(jsonString)).map((e) => e as Map<String, dynamic>).toList();
}
