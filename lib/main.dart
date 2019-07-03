import 'package:flutter/material.dart';

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
  final emailControll = TextEditingController();
  final senhaControll = TextEditingController();
  final String email = "joao";
  final String senha = "1234";
  Widget retornoFuncao;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _widgetPadrao() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Login'),
            controller: emailControll,
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
    setState(() {
      retornoFuncao = CircularProgressIndicator();
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      retornoFuncao = _widgetPadrao();
    });
    if (email == emailControll.text && senha == senhaControll.text) {

      final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
     _scaffoldKey.currentState.showSnackBar(snackBar);

    } else {
      final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
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
