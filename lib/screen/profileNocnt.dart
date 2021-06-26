import 'package:Arabi21Login/screen/login.dart';
import 'package:Arabi21Login/screen/profil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilNoCnt extends StatefulWidget {
  @override
  _ProfilNoCntState createState() => _ProfilNoCntState();
}

class _ProfilNoCntState extends State<ProfilNoCnt> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = Profil();
    } else {
      child = Login();
    }
    return Scaffold(
      body: child,
    );
  }
}
