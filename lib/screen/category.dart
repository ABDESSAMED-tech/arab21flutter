import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'diffcate.dart';

class Favorit extends StatefulWidget {
  @override
  _FavoritState createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  Future getPosts() async {
    var resp = await http.get("http://192.168.43.22:8000/api/categories");
    if (resp.statusCode == 200) {
      //200=succés
      var obj = json.decode(resp.body);
      return obj;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    getPosts();
  }

  bool isAuth = false;
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "                                              البوابات ",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: "advertisingbold",
              fontSize: 21,
            ),
          ),
          backgroundColor: Color(0xffa257ba),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: FutureBuilder(
          future: getPosts(),
          builder: (ctx, snapshot) {
            //snapshot=obj
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              )));
            } else {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                        child: Column(
                      children: [
                        FlatButton(
                          splashColor: Colors.amberAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ArticlCat(
                                          Url:
                                              "http://ar21.pixelvibes.co.uk/api/posts/?filter[category_id]=${snapshot.data['data'][index]['id']}",
                                          title: snapshot.data['data'][index]
                                              ['name'],
                                          isAuth: isAuth,
                                        )));
                          },
                          child: Column(children: [
                            Text(
                              snapshot.data['data'][index]['name'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'advertisingbold',
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                  );
                },
                itemCount: 14,
              );
            }
          },
        )));
  }
}
