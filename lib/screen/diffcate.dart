import 'package:Arabi21Login/screen/Video.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';
import 'package:html/parser.dart';

import 'profileNocnt.dart';

class ArticlCat extends StatelessWidget {
  final String Url, title;
  final bool isAuth;
  const ArticlCat({Key key, this.Url, this.title, this.isAuth});

  Future getPosts() async {
    var resp = await http.get(this.Url);
    if (resp.statusCode == 200) {
      //200=succés
      var obj = json.decode(resp.body);
      return obj;
    }
  }

  void _showDialog(title, excerpt, content, author, image, context) {
    // flutter defined function
    bool click = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          scrollable: true,
          title: new Text(
            title,
            style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'advertisingbold',
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          content: new Column(
            children: [
              Image.network(image),
              Html(data: excerpt),
              Html(data: content),
              Text(
                author,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'advertisingbold',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: click ? Icon(Icons.star_border) : Icon(Icons.star),
              onPressed: () {
                click = true;
              },
            ),
            new FlatButton(
              onPressed: () async {
                SocialShare.shareOptions(
                    _parseHtmlString("$title \n $excerpt \n $content"));
              },
              child: new Icon(
                Icons.share,
              ),
            )
          ],
        );
      },
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    var title, excerpt, content, author, image, category;
    bool click = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "                                     ${this.title} ",
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ));
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
                        onPressed: () {
                          category =
                              snapshot.data['data'][index]['category']['name'];
                          title = snapshot.data['data'][index]['title'];
                          excerpt = snapshot.data['data'][index]['excerpt'];
                          content = snapshot.data['data'][index]['content'];
                          author = snapshot.data['data'][index]['author'];
                          image = snapshot.data['data'][index]['image'];
                          if (excerpt == null || content == null) {
                            print("excerpt==null");
                          } else if (category == "عربي21 TV") {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Videos()));
                          } else {
                            _showDialog(title, excerpt, content, author, image,
                                context);
                            print(category);
                          }
                        },
                        child: Image.network(
                          '${snapshot.data['data'][index]['image']}',
                          width: double.infinity,
                        ),
                      ),
                      Text(
                        snapshot.data['data'][index]['title'],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'advertisingbold',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data['data'][index]['category']['name'],
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'jalah',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            SizedBox(
                              width: 200,
                            ),
                            FlatButton(
                                onPressed: () {
                                  if (isAuth) {
                                  } else {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilNoCnt()));
                                  }
                                },
                                child: Image.asset(
                                  'assets/nofavorites.ico',
                                  color: Colors.black,
                                )),
                            FlatButton(
                                onPressed: () async {
                                  title = snapshot.data['data'][index]['title'];
                                  excerpt =
                                      snapshot.data['data'][index]['excerpt'];
                                  content =
                                      snapshot.data['data'][index]['content'];
                                  author =
                                      snapshot.data['data'][index]['author'];

                                  SocialShare.shareOptions(_parseHtmlString(
                                      "$title \n $excerpt \n $content \n $author"));
                                },
                                child: Icon(Icons.share)),
                          ],
                        ),
                      )
                    ],
                  )),
                );
              },
              itemCount: 50,
            );
          }
        },
      )),
    );
  }
}
