import 'dart:convert';

import 'package:app_dubaothoitiet/api/api_key.dart';
import 'package:app_dubaothoitiet/pages/login_page.dart';
import 'package:app_dubaothoitiet/utils/share_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String apiURLWeather(var lat, var lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}

class MongoDBAPI {
  static String baseUrl =
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-agxhb/endpoint/data/v1/action/';
  static String findOne = 'findOne';
  static String findMultiRow = 'find';
  static String insertOne = 'insertOne';
  static String updateOne = 'updateOne';
  static String deleteOne = 'deleteOne';

  String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJiYWFzX2RldmljZV9pZCI6IjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCIsImJhYXNfZG9tYWluX2lkIjoiNjU2OWY1MTk5MDUzZjA4MmFhNDAwNzFlIiwiZXhwIjoxNzAxNTMyNTIzLCJpYXQiOjE3MDE1MzA3MjMsImlzcyI6IjY1NmI0YzYzMGY3NGQ3YTM1ODRlMDg0OCIsInN0aXRjaF9kZXZJZCI6IjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCIsInN0aXRjaF9kb21haW5JZCI6IjY1NjlmNTE5OTA1M2YwODJhYTQwMDcxZSIsInN1YiI6IjY1NjlmN2JlOTA1M2YwODJhYTQzM2M1OCIsInR5cCI6ImFjY2VzcyJ9.NEK8jpTGQuREWsGDFDYnDAYJfcjfikya65kwE9JwgGM';

  Future<dynamic> insertOneCallMongo(BuildContext context,
      {String collection = 'weather', Map<String, dynamic>? document}) async {
    accessToken = await LocalStorage.read('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Request-Headers': '*',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl$insertOne'));
    request.body = json.encode({
      "dataSource": "Cluster0",
      "database": "dưbaothoitiet",
      "collection": collection,
      "document": {
        ...document??{},
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200){
      return await response.stream.bytesToString();
    } else {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
      }
    }
  }

  Future<dynamic> findOneCallMongo(BuildContext context,
      {String collection = 'weather', Map<String, dynamic>? filters}) async {
    accessToken = await LocalStorage.read('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Request-Headers': '*',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl$findOne'));
    request.body = json.encode({
      "collection": collection,
      "database": "dưbaothoitiet",
      "dataSource": "Cluster0",
      "filter": {
        ...filters ?? {},
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      await LocalStorage.save('access_token', '');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
    }
  }

  Future<dynamic> findMultiCallMongo(BuildContext context,
      {String collection = 'weather',
      Map<String, dynamic>? filters,
      Map<String, dynamic>? sorts}) async {
    accessToken = await LocalStorage.read('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Request-Headers': '*',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl$findMultiRow'));
    request.body = json.encode({
      "collection": collection,
      "database": "dưbaothoitiet",
      "dataSource": "Cluster0",
      "filter": {
        ...filters ?? {},
      },
      "sort": {
        ...sorts ?? {},
      },
      "limit": 10
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      await LocalStorage.save('access_token', '');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
    }
  }

  Future<dynamic> updateOneCallMongo(
    BuildContext context,{String collection = 'weather',
        String id= '',
        Map<String, dynamic>? dataUpdates}
  ) async {
    accessToken = await LocalStorage.read('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Request-Headers': '*',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request(
        'POST',
        Uri.parse('$baseUrl$updateOne'));
    request.body = json.encode({
      "dataSource": "Cluster0",
      "database": "dưbaothoitiet",
      "collection": "user",
      "filter": {
        "_id": {"\$oid": id}
      },
      "update": {
        "\$set":{
          ...dataUpdates??{},
        },
      }
    }).toString();
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      await LocalStorage.save('access_token', '');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
    }
  }

  Future<dynamic> deleteOneCallMongo(
      BuildContext context,{String collection = 'weather',
        Map<String, dynamic>? filters,
        Map<String, dynamic>? sorts, String id=''}) async {
    accessToken = await LocalStorage.read('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Request-Headers': '*',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl$deleteOne'));
    request.body = '''{\n    "dataSource": "Cluster0",\n    "database": "dưbaothoitiet",\n    "collection": "$collection",\n    "filter": {\n      "_id": { "\$oid": "$id" }\n    }\n  }''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      await LocalStorage.save('access_token', '');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
      }
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://realm.mongodb.com/api/client/v2.0/app/data-agxhb/auth/providers/local-userpass/login'));
    request.headers.addAll(headers);
    request.body = json.encode({
      'username':email,
      'password':password
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
  }

}
