import 'dart:io';
import 'dart:convert';

Future<String> _readTestData(
  String fileName, {
  String filePath = 'assets/json/',
}) async {
  final file = File(filePath + fileName);
  return await file.readAsString();
}

Future<Map<String, dynamic>> readTestDataObject(path) async {
  final data = await _readTestData(path);
  return json.decode(data)['data'];
}

Future<List<Map<String, dynamic>>> readTestDataList(String path) async {
  final data = await _readTestData(path);
  return List<Map<String, dynamic>>.from(json.decode(data)['data']);
}
