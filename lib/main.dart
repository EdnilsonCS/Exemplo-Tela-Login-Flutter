import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Tela de Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final usuarioControll = TextEditingController();
  final senhaControll = TextEditingController();
  final String usuario = "joao";
  final String senha = "1234";
  Widget retornoFuncao;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _widgetPadrao() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Login'),
            controller: usuarioControll,
            autocorrect: true,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            controller: senhaControll,
            obscureText: true,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: onChange,
          )
        ],
      );

  onChange() async {
    Dio dio = new Dio();

    final tokenEndpoint =
        "https://apisistemas.desenvolvimento.ufs.br/api/rest/token";


    final optionsDefault = RequestOptions(

      headers: {'Content-Type': 'application/x-www-form-urlencoded'});

    
    FormData getFromDataAccessTokenPost(login, senha) => FormData.from({

        "client_id": "696a8721813f19e86fc272afb4761a18",

        "client_secret": "c8729006256b7218dcdf549b87a7e51e",

        "grant_type": "password",

        "username": login,

        "password": md5.convert(utf8.encode(senha)).toString()

      });

      Response response = await dio.post(tokenEndpoint,

          queryParameters: getFromDataAccessTokenPost("ednilsoncardoso", ""), options:  optionsDefault);

    setState(() {
      retornoFuncao = CircularProgressIndicator();
    });
    setState(() {
      retornoFuncao = _widgetPadrao();
    });

    if (usuario == usuarioControll.text && senha == senhaControll.text) {
      final snackBar = SnackBar(content: Text('Autenticado com sucesso'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Erro na autenticação'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retornoFuncao = _widgetPadrao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: retornoFuncao),
    );
  }
}
