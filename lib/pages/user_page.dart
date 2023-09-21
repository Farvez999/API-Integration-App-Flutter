import 'dart:convert';

import 'package:api_integration/Models/UserModel.dart';
import 'package:api_integration/components/reusbalRow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User API",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: "Name",
                                        value: snapshot.data![index].name
                                            .toString()),
                                    ReusableRow(
                                        title: "User Name",
                                        value: snapshot.data![index].username
                                            .toString()),
                                    ReusableRow(
                                        title: "Email",
                                        value: snapshot.data![index].email
                                            .toString()),
                                    ReusableRow(
                                        title: "Address",
                                        value: snapshot
                                                .data![index].address!.city
                                                .toString() +
                                            snapshot
                                                .data![index].address!.geo!.lat
                                                .toString())
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
