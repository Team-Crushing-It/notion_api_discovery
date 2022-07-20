import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notion_api_discovery/notionKey.dart';
import 'package:notion_api_discovery/notion_api.dart';

void main(List<String> arguments) async {
  NotionApi notion = NotionApi(
      databaseID: "6205ce8c59e149009cff1f1e5c965e3c", notionKey: NotionKey.key);
  await notion.retrieveDatabaseItem();
}
// this is the database id
// 6205ce8c59e149009cff1f1e5c965e3c


