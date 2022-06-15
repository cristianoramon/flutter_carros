import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }
}

_body() {
  return ListView(
    children: <Widget>[
      Text("Login "),
      TextFormField(),
      Text("Senha"),
      TextField(),
      ElevatedButton(
          onPressed: () => {},
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          )),
    ],
  );
}
