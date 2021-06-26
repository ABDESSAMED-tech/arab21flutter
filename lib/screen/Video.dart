import 'dart:convert';

import 'package:Arabi21Login/screen/profileNocnt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
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

  // ignore: unused_element
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  Future getPosts() async {
    var resp = await http.get("http://ar21.pixelvibes.co.uk/api/videos");
    if (resp.statusCode == 200) {
      //200=succés
      var obj = json.decode(resp.body);
      return obj;
    }
  }

  YoutubePlayerController _controller(id) {
    return YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
  }

  var title, excerpt, url, author, image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    YoutubePlayer(
                      controller: _controller(
                          "${snapshot.data['data'][index]['video_id']}"),
                      onReady: () {
                        print('Player is ready.');
                      },
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
                                        builder: (context) => ProfilNoCnt()));
                              }
                            },
                            child: Image.asset(
                              'assets/nofavorites.ico',
                              color: Colors.black,
                            ),
                          ),
                          FlatButton(
                              onPressed: () async {
                                SocialShare.shareOptions(_parseHtmlString(
                                    "${snapshot.data['data'][index]['title']} \n ${snapshot.data['data'][index]['url']} \n "));
                              },
                              child: Icon(Icons.share)),
                        ],
                      ),
                    ),
                  ],
                )),
              );
            },
            itemCount: 50,
          );
        }
      },
    )));
  }
}
