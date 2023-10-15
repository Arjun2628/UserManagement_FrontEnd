import 'dart:convert';

import 'package:firstnode_frontend/data/api/users.dart';
import 'package:firstnode_frontend/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<UserModel> userdetails = [];

  getUserData(List<UserModel> data) {
    userdetails = data;
    notifyListeners();
  }

  // get all users
  Future<void> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse(allUsersApi));

      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        List<UserModel> users =
            data.map((user) => UserModel.fromJson(user)).toList();
        // return users;
        userdetails = users;
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load users, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

//  add new user
  Future<void> addUser(String username) async {
    try {
      var url = Uri.parse("http://10.0.12.146:3001/adduser/$username");
      var response = await http.post(url);

      if (response.statusCode == 200) {
        // print("User added successfully");
        Iterable data = jsonDecode(response.body);
        List<UserModel> users =
            data.map((user) => UserModel.fromJson(user)).toList();
        // return users;
        userdetails = users;
        notifyListeners();
      } else {
        print("Failed to add user, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to add user: $e");
    }
  }

  Future<void> updateUser(String id, String name) async {
    var url = Uri.parse(updateUserApi);
    var body = jsonEncode({"id": id, "name": name});

    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      List<UserModel> users =
          data.map((user) => UserModel.fromJson(user)).toList();
      // return users;
      userdetails = users;
      notifyListeners();
      // print('User updated successfully');
      // print(jsonDecode(response.body));
    } else {
      print('Failed to update user. Error: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String id) async {
    var url = Uri.parse(deleteUserApi);
     var body = jsonEncode({"id": id});

     var response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

      if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      List<UserModel> users =
          data.map((user) => UserModel.fromJson(user)).toList();
      // return users;
      userdetails = users;
      notifyListeners();
      // print('User updated successfully');
      // print(jsonDecode(response.body));
    } else {
      print('Failed to update user. Error: ${response.statusCode}');
    }

  }
}
