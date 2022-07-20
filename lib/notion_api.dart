import 'dart:convert';

import 'package:http/http.dart' as http;

class NotionApi {
  final String databaseID;
  final String notionKey;
  late final Map<String, String> headers;
  NotionApi({required this.databaseID, required this.notionKey}) {
    headers = {
      "Authorization": "Bearer $notionKey",
      "Content-Type": "application/json",
      "Notion-Version": "2021-08-16"
    };
  }

  // available colors : 
  // light gray, gray, brown, orange, yellow 
  // green, blue, purple, pink, red
  /// Add an item to notion database
  Future<Map<String, dynamic>> addDatabaseItem(

      {required String itemTitle,required String name, String status = "Not Started",String statusColor = "gray"}) async {

    // item properties
    Map<String, dynamic> body = {
      "parent": {"type": "database_id", "database_id": databaseID},
      "properties": {
        "Name": {
          "type": "title",
          "title": [
            {
              "type": "text",
              "text": {"content": itemTitle}
            }
          ]
        },
        "name": {
          "type": "rich_text",
          "rich_text": [
            {
              "type": "text",
              "text": {"content": name}
            }
          ]
        },
        "Status": {
          "multi_select": [
            {"name": status, "color": "yellow"}
          ]
        }
      }
    };
    // post request to notion api
    http.Response response = await http.post(
        Uri.parse("https://api.notion.com/v1/pages"),
        headers: headers,
        body: jsonEncode(body));

    // logs
    console("response", response.body.toString());
    console("status code", response.statusCode.toString());
    return jsonDecode(response.body);
  }
  
  Future<Map<String,dynamic>> retrieveDatabaseItem() async{

        // filter item properties
    Map<String, dynamic> body = {
      "filter": {
      "property": "Status",
      "multi_select": 
        {"contains" : "Not started"}
      
        },
    };
    // post request to notion api
    http.Response response = await http.post(
        Uri.parse("https://api.notion.com/v1/databases/$databaseID/query"),
        headers: headers,
        body: jsonEncode(body));

    // logs
    console("response", response.body.toString());
    console("status code", response.statusCode.toString());
    return jsonDecode(response.body);
  }
  
  // logs prettier
  void console(String title, String content) {
    print('$title : $content');
  }
}
