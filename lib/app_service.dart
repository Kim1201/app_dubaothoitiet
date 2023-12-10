import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:http/http.dart' as http;

class AppServices {
  String id;
  Uri baseUrl;
  App app;
  User? currentUser;

  AppServices(this.id, this.baseUrl)
      : app = App(AppConfiguration(id, baseUrl: baseUrl, httpClient: HttpClient()));

  Future<void> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
  }
}
