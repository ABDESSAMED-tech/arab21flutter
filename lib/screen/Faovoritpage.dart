import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

//this page for  show user fovorite
class _FavoritePageState extends State<FavoritePage> {
  Future getPosts() async {
    var resp = await http.get("http://192.168.43.22:8000/api/favourite");
    if (resp.statusCode == 200) {
      //200=succés
      var obj = json.decode(resp.body);
      return obj;
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "الأخبـــار المفضلة",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontFamily: 'jalah',
                fontWeight: FontWeight.w300),
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
                          onPressed: () {},
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
