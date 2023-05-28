import 'package:flutter/material.dart';
import 'package:sqlite_crud/screens/adduser.dart';
import 'package:sqlite_crud/screens/editUser.dart';
import 'package:sqlite_crud/screens/viewuswe.dart';
import 'package:sqlite_crud/sevices/userservices.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userlist = <User>[];
  final _userServices = UserServices();

  getallUserDetails() async {
    var users = await _userServices.raadAllUser();
    _userlist = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userlist.add(userModel);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallUserDetails();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFromDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text(
              "Are you Sure to Delete",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userServices.deletUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getallUserDetails();
                      _showSuccessSnackBar('user Detail Deleted Success');
                    }
                  },
                  child: Text("Delete")),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite CURD")),
      body: ListView.builder(
          itemCount: _userlist.length,
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                                user: _userlist[index],
                              ))).then((value) {
                    if (value != null) {
                      getallUserDetails();
                      _showSuccessSnackBar('user detail updated success');
                    }
                  });
                },
                leading: Icon(Icons.person),
                title: Text(_userlist[index].name ?? ""),
                subtitle: Text(_userlist[index].contact ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUser(
                                        user: _userlist[index],
                                      ))).then((value) {
                            if (value != null) {
                              getallUserDetails();
                              _showSuccessSnackBar(
                                  'user detail update success');
                            }
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFromDialog(context, _userlist[index].id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((value) {
            if (value != null) {
              getallUserDetails();
              _showSuccessSnackBar('user detail added success');
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
