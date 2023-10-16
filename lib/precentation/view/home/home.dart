import 'package:firstnode_frontend/data/http/http.dart';
import 'package:firstnode_frontend/data/provider/userApiprovider.dart';
import 'package:firstnode_frontend/data/provider/userProvider.dart';
import 'package:firstnode_frontend/domain/models/user_model/user_model.dart';
import 'package:firstnode_frontend/precentation/view/manage_users/add_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // AllUsers allUsers=AllUsers();
    // allUsers.getAllUsers();
    Provider.of<UserApiProvider>(context, listen: false).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.home,
          color: Colors.white,
        ),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Consumer<UserApiProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.userdetails.length,
          itemBuilder: (context, index) {
            UserModel user = value.userdetails[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _editUserBottomSheet(context, user);
                },
                onLongPress: () async {
                  //  await Provider.of<UserProvider>(context, listen: false)
                  //       .deleteUser(user.id!);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Do you want to delete this user?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          ElevatedButton(
                              onPressed: () async {
                                await Provider.of<UserApiProvider>(context,
                                        listen: false)
                                    .deleteUser(user.id!);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'))
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  color: Colors.grey,
                  child: ListTile(
                    leading: Container(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.profileImage!),
                      ),
                    ),
                    title: Text(
                      user.name!,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      user.email!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUser(),
              ));
          // _showBottomSheet(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Add"),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    TextEditingController userController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: userController,
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        if (value.photo != null) {
                          if (value.nameController.text != "") {
                            if (value.ageController.text != "") {
                              if (value.emailController.text != "") {
                                await value.cloudAdd(value.photo!);
                                Map<String, dynamic> newUser = {
                                  "name": value.nameController.text,
                                  "age": value.ageController.text,
                                  "email": value.emailController.text
                                };
                                await Provider.of<UserApiProvider>(context,
                                        listen: false)
                                    .addUser(newUser);
                                Navigator.pop(context);
                              }
                            }
                          }
                        }
                        // await Provider.of<UserApiProvider>(context, listen: false)
                        //     .addUser();
                        Navigator.pop(context);
                      },
                      child: Text("Add new user")),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _editUserBottomSheet(BuildContext context, UserModel user) {
    TextEditingController userController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: userController,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Provider.of<UserApiProvider>(context, listen: false)
                          .updateUser(user.id!, userController.text);
                      Navigator.pop(context);
                    },
                    child: Text("Update user"))
              ],
            ),
          ),
        );
      },
    );
  }
}
