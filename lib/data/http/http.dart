import 'dart:convert';

import 'package:firstnode_frontend/data/api/users.dart';
import 'package:firstnode_frontend/domain/models/user_model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllUsers {
  
// get all users
  Future<void> getAllUsers() async {
  try {
    final response = await http.get(Uri.parse(allUsersApi));

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      List<UserModel> users = data.map((user) => UserModel.fromJson(user)).toList();
      // return users;
     
    } else {
      throw Exception('Failed to load users, status code: ${response.statusCode}');
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

    if (response.statusCode == 201) {
      print("User added successfully");
    } else {
      print("Failed to add user, status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to add user: $e");
  }
}
}
