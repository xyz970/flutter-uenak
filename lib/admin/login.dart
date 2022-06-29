import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:uenak/admin/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String username, password;
  // late String username;
  bool isLoading = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            key: _scaffoldKey,
            body: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Center(
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold)),
                ),
                Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 45),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Username",
                            ),
                            onSaved: (val) {
                              username = val!;
                            },
                            controller: _usernameController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                            onSaved: (val) {
                              password = val!;
                            },
                            controller: _passwordController,
                          )
                        ],
                      ),
                    )),
                Center(
                  child: ElevatedButton(
                    child: Text("Login"),
                    onPressed: () {
                      login(_usernameController.text, _passwordController.text);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  login(username, password) async {
    Map data = {'username': username, 'password': password};
    print(data.toString());
    final response =
        await http.post(Uri.parse("http://localhost/uenak-ci/api/admin/login"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode != 402) {
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => Admin(),));
      } else {
        // print(data.);
        scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Mohon cek  username dan password anda!")));
      }
      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("${data['message']}")));
    } else {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Uppss, Ada yang salah!!")));
    }
  }

  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
}
