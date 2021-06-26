import 'dart:convert';
import 'dart:io';
import 'package:Arabi21Login/network_utils/api.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var fname;
  var lname;
  var phone;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black12,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/headerlogo.ico'),
                    SizedBox(
                      height: 40,
                    ),
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: "حساب البريد",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (emailValue) {
                                  if (emailValue.isEmpty) {
                                    return 'من فضلك ادخل حساب البريد';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "الإسم ",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (firstname) {
                                  if (firstname.isEmpty) {
                                    return 'من فضلك ادخل الإسم !';
                                  }
                                  fname = firstname;
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "اللقب",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (lastname) {
                                  if (lastname.isEmpty) {
                                    return 'من فضلك ادخل اللقب ';
                                  }
                                  lname = lastname;
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  hintText: "الهاتف ",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (phonenumber) {
                                  if (phonenumber.isEmpty) {
                                    return 'من فضلك ادخل رقم الهاتف ';
                                  }
                                  phone = phonenumber;
                                  return null;
                                },
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "كلمة السر ",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'أدخل كلمة السر من فضلك';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? '...جاري التسجيل '
                                          : 'تسجيل ',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.teal,
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _register();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Text(
                          'لديك حساب مسبقا ',
                          style: TextStyle(
                            fontFamily: "jalah",
                            color: Colors.blue,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': fname,
      'email': email,
      'password': password,
      'phone': phone,
      'last_name': lname,
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
}
