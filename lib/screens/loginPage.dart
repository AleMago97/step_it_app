import 'package:flutter/material.dart';
import 'package:step_it_app/screens/homePage.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  } //initState

  void _checkLogin() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null) {
      _toHomePage(context);
    } //if
  } //_checkLogin

  Future<String> _loginUser(LoginData data) async {
    if (data.name == 'cca@unipd.it' && data.password == 'UNIPD') {
      final sp = await SharedPreferences.getInstance();
      sp.setString('username', data.name);

      return '';
    } else {
      return 'Wrong credentials';
    }
  }

  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  }

  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 247, 151, 27),
        accentColor: Colors.white,
        errorColor: Colors.amber,
      ),
      logo: AssetImage("assets/images/logo.png"),
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        _toHomePage(context);
      },
    );
  }

  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomePage.route);
  } //_toHomePage

}
