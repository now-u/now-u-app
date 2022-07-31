import 'dart:io';
import 'dart:convert';

Future<String> readTestData(String fileName,
    {String filePath = "assets/json/"}) async {
  final file = File(filePath + fileName);
  return await file.readAsString();
}

Future<List<Map<String, dynamic>>> readTestDataList(String path) async {
  final data  = await readTestData(path);
  return new List<Map<String, dynamic>>.from(json.decode(data)["data"]);
}

// Future<List<Map<String, dynamic>>> readTestDataObject() async {
//   final data  = await readTestData("news.json");
//   return new List<Map<String, dynamic>>.from(json.decode(data)["data"]);
// }
