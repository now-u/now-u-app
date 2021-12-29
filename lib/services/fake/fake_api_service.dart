import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Directory findRoot(FileSystemEntity entity) {
  final Directory parent = entity.parent;
  if (parent.path == entity.path) return parent;
  return findRoot(parent);
}

abstract class FakeApiService {
  Future<String> readDataFromFile(String fileName) async {
    return await rootBundle.loadString('assets/json/$fileName');
  }

  Future<Iterable> readIterableDataFromFile(String fileName) async {
    String response = await readDataFromFile(fileName);
    dynamic data = json.decode(response)["data"];
    return data is Iterable ? data : Iterable.empty();
  }
}
