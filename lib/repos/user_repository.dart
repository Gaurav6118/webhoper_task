import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webhoper_test/model/user_model.dart';

// This Class is used for call all api's and also save data into local
class UserRepository {
  UserModel? user;

// This function call for get login data from sharedPreferences
  Future<UserModel?> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      var userMap =
          jsonDecode(prefs.getString('current_user')!) as Map<String, dynamic>;
      user = UserModel.fromJson(userMap);
    } else {
      debugPrint("user null");
      return user;
    }
    return user;
  }

// This function call for save login data using sharedPreferences
  Future<void> setCurrentUser(UserModel jsonString) async {
    try {
      if (jsonEncode(jsonString).isNotEmpty) {
        var prefs = await SharedPreferences.getInstance();
        await prefs
            .setString('current_user', jsonEncode(jsonString.toJson()))
            .then((value) {
          updateUserInstance();
        });
      }
    } catch (e, stack) {
      throw Exception(e);
    }
  }

//
  void updateUserInstance() {
    user = null;
    getCurrentUser();
  }

//
  void clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      prefs.remove('current_user');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    return user;
  }

  Future<http.Response> logIn({Map<dynamic, dynamic>? data}) async {
    const url = "https://reqres.in/api/login";

    debugPrint("MapData $data");

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));

    debugPrint('Response ${response.body}');

    return response;
  }

  Future<http.Response> getUserData() async {
    const url = "https://reqres.in/api/unknown";

    debugPrint('URL $url');

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
    });

    debugPrint('Response ${response.body}');

    return response;
  }
}
