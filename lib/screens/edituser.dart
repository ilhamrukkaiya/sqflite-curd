import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/user.dart';
import '../sevices/userservices.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _usernamecontlr = TextEditingController();
  var _usercontectcontlr = TextEditingController();
  var _userdescribetioncontlr = TextEditingController();
  bool _validatename = false;
  bool _validatecontect = false;
  bool _validatedescrpt = false;
  var _userService = UserServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _usernamecontlr.text = widget.user.name ?? "";
      _usercontectcontlr.text = widget.user.contact ?? "";
      _userdescribetioncontlr.text = widget.user.description ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SQLite CURD"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Edit New User",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: _usernamecontlr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter Name",
                        labelText: "Name",
                        errorText:
                            _validatename ? 'Value can\'t be empty' : null)),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _usercontectcontlr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Enter phone no",
                      labelText: "Phone No",
                      errorText:
                          _validatecontect ? 'Value can\'t be empty' : null),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _userdescribetioncontlr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Enter Description",
                      labelText: "Description",
                      errorText:
                          _validatedescrpt ? 'Value can\'t be empty' : null),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            textStyle: TextStyle(fontSize: 15)),
                        onPressed: () async {
                          // setState(() {
                          //   _usernamecontlr.text.isEmpty
                          //       ? _validatename = true
                          //       : _validatename = false;
                          //   _usercontectcontlr.text.isEmpty
                          //       ? _validatecontect = true
                          //       : _validatecontect = false;
                          //   _userdescribetioncontlr.text.isEmpty
                          //       ? _validatedescrpt = true
                          //       : _validatedescrpt = false;
                          // });
                          // if (_validatename == false &&
                          //     _validatecontect == false &&
                          //     _validatedescrpt) {
                          var _user = User();
                          _user.id = widget.user.id;
                          _user.name = _usernamecontlr.text;
                          _user.contact = _usercontectcontlr.text;
                          _user.description = _userdescribetioncontlr.text;
                          var result = await _userService.UpdateUser(_user);
                          Navigator.pop(context, result);
                          // }
                        },
                        child: Text("Update Detail")),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.redAccent,
                            textStyle: TextStyle(fontSize: 15)),
                        onPressed: () {
                          _usernamecontlr.text = "";
                          _usercontectcontlr.text = "";
                          _userdescribetioncontlr.text = "";
                        },
                        child: Text("clear Detail"))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
