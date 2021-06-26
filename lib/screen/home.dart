import 'package:Arabi21Login/screen/profileNocnt.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AboutAs.dart';
import 'Video.dart';
import 'articl.dart';
import 'cantactUs.dart';
import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> tabs = [
    AboutAs(),
    Videos(),
    Articl(),
    Favorit(),
    ProfilNoCnt(),
    ContactUsPage(),
  ];
  int _page = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 70.0,
        items: <Widget>[
          Container(
            child: Icon(
              FontAwesomeIcons.infoCircle,
              color: Color(0xffffffff),
              size: 20,
            ),
          ),
          Icon(
            FontAwesomeIcons.video,
            color: Color(0xffffffff),
            size: 20,
          ),
          Icon(FontAwesomeIcons.newspaper, color: Color(0xffffffff), size: 20),
          Icon(FontAwesomeIcons.safari, color: Color(0xffffffff), size: 20),
          Icon(Icons.person, color: Color(0xffffffff), size: 20),
          Icon(Icons.contact_mail, color: Color(0xffffffff), size: 20),
        ],
        color: Color(0xffa257ba),
        buttonBackgroundColor: Color(0xffa257ba),
        backgroundColor: Color(0xffffffff),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: tabs[_page],
    );
  }

  void customURlLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }
}
