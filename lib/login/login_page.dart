import 'package:flutter/material.dart';
import 'package:flutter_carros/carro/home_page.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'package:flutter_carros/widgets/app_button.dart';
import 'package:flutter_carros/widgets/app_text.dart';



class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final tLogin = TextEditingController();

  final tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
                label: "Login",
                hint: "Digite  Login",
                passwd: false,
                contro: tLogin,
                validator: _validarLogin),
            SizedBox(height: 10),
            AppText(
                label: "Senha",
                hint: "Digite  Senha",
                passwd: true,
                contro: tSenha,
                validator: _validarsenha),
            SizedBox(height: 10),
            Container(
              height: 46,
              child: AppButton(label: "Login", onPressed: _onClickLogin),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() {
    String login;
    login = tLogin.text;

    print("login $login");

    bool fomrKey = _formKey.currentState!.validate();
   
    if (fomrKey) {
      push(context, HomePage());
      return;
    }
    
  }

  String? _validarLogin(value) {
    if (value == null || value.isEmpty) {
      return "Digite Login";
    } else {
      return null;
    }
  }

  String? _validarsenha(value) {
    if (value == null || value.isEmpty) {
      return "Digite Senha";
    } else {
      return null;
    }
  }
}
