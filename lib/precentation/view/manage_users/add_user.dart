import 'dart:io';

import 'package:firstnode_frontend/data/provider/userApiprovider.dart';
import 'package:firstnode_frontend/data/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Consumer<UserProvider>(
          builder: (context, user, child) => ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () async {
                        await value.getImage(ImageSource.gallery);
                      },
                      child: value.photo != null
                          ? CircleAvatar(
                              radius: size.height * 0.09,
                              backgroundImage:
                                  FileImage(File(value.photo!.path)),
                            )
                          : CircleAvatar(
                              radius: size.height * 0.09,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, top: 5, bottom: 5),
                      child: TextField(
                        controller: user.nameController,
                        decoration: InputDecoration(hintText: "User name"),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, top: 5, bottom: 5),
                      child: TextField(
                        controller: user.ageController,
                        decoration: InputDecoration(hintText: "Age"),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, top: 5, bottom: 5),
                      child: TextField(
                        controller: user.emailController,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                        onPressed: ()async{
                           if (user.photo != null) {
                          if (user.nameController.text != "" 
                              ) {
                            if (user.ageController.text != "" 
                                ) {
                              if (user.emailController.text != "" 
                                 ) {
                                await user.cloudAdd(user.photo!);
                                Map<String, dynamic> newUser = {
                                  "name": user.nameController.text,
                                  "age": user.ageController.text,
                                  "email": user.emailController.text,
                                  "profileImage":user.imageUri
                                };
                                await Provider.of<UserApiProvider>(context,
                                        listen: false)
                                    .addUser(newUser);
                                Navigator.pop(context);
                              }
                            }
                          }
                        }
                        }, child: Text("Add user"))),
              )
            ],
          ),
        ),
      )),
    );
  }
}
