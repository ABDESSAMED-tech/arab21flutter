import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAs extends StatefulWidget {
  @override
  _AboutAsState createState() => _AboutAsState();
}

class _AboutAsState extends State<AboutAs> {
  @override
  static final mainColor = Color(0xffa257ba);
  static final secondColor = Color(0xff344672);
  static final redColor = Color(0xffdc3636);
  static final whiteColor = Color(0xffffffff);
  static final facebookUrl = "https://www.facebook.com/Arabi21News";
  static final twitterUrl = "https://twitter.com/Arabi21News";
  static final websiteUrl = "https://arabi21.com/";
  static final youtubeUrl = "https://www.youtube.com/user/Arabi21News";
  static String discoveryImageHeader =
      'https://www.facebook.com/820262131363591/photos/3876404355749338/';
  static String contactUsHeaderImage =
      'https://images.unsplash.com/photo-1560438718-eb61ede255eb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1900&q=80';
  static String infoHeaderImage =
      'https://arabi21.com/Content/images/headerLogo.png';
  static String ourCategoriesHeaderImage =
      "https://images.unsplash.com/photo-1542317854-f9596ae570f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE3MzYxfQ&auto=format&fit=crop&w=3300&q=80";
  static String visionImage =
      "https://arabi21.com/Content/images/headerLogo.png";
  static String missionImage = "https://twitter.com/Arabi21News/header_photo";
  static String infoParagraphMission =
      "صحيفة عربية إلكترونية إخبارية مستقلة شاملة تسعى لتقديم الخبر والتحليل والرأي للمتصفح العربي في كل مكان. ونظرا لحرص الصحيفة على تتبع الخبر في مكان حدوثه، فإنها تمتلك شبكة واسعة من المراسلين في غالبية العالم يتابعون التطورات السياسية في العواصم العربية على مدار الساعة. ";
  static String infoParagraphVision =
      "سعى العربى21 إلى المساهمة في خلق فضاء إلكتروني يتمتع بالمصداقية، ولذلك فهي لا تتبع لأيديولوجيا معينة، ولا تنحاز إلا لقيم الحرية والكرامة وتطلعات الشعوب عربية، دون الانجرار إلى بروباغاندا غير مهنية وغير علمية. وفي وقت تمر فيه المنطقة عربية بمحاولات حقيقية للتغيير السياسي الشامل، فإن صحيفة عربي21 تؤمن بحق الشعوب في التغيير السلمي؛ دون اللجوء إلى العنف أو الانقسامات على أسس عرقية أو طائفية، ولذلك فإن الصحيفة ترفض الانجرار وراء دعوات الشحن والتحريض الطائفي في العالم العربى. ";
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffa257ba),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://arabi21.com/Content/images/headerLogo.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 00.0, right: 10, left: 10),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff344672).withOpacity(0.4),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 8.0, right: 10),
                    child: Text(
                      '                                                     تابعنا ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xffa257ba),
                          fontSize: 15,
                          fontFamily: 'jalah',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              customURlLaunch(facebookUrl);
                            },
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: secondColor,
                            )),
                        InkWell(
                            onTap: () {
                              customURlLaunch(twitterUrl);
                            },
                            child: Icon(
                              FontAwesomeIcons.twitter,
                              color: secondColor,
                            )),
                        InkWell(
                            onTap: () {
                              customURlLaunch(youtubeUrl);
                            },
                            child: Icon(
                              FontAwesomeIcons.youtube,
                              color: secondColor,
                            )),
                        InkWell(
                            onTap: () {
                              customURlLaunch(websiteUrl);
                            },
                            child: Icon(
                              FontAwesomeIcons.globe,
                              color: secondColor,
                            )),
                      ],
                    ),
                  ),
                  _aboutUsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Create about Us Card
  Widget _aboutUsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //name Of our Company or Brand

        //name Of our Vision or Brand

        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 18),
          child: Text(
            '                                                من نحن',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'jalah',
                color: mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    infoParagraphMission,
                    style: TextStyle(
                      fontFamily: 'abdoullah',
                      color: secondColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),

        //Our Mission
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10),
          child: Text(
            '                                               مهمتنا ',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'jalah',
                color: mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    infoParagraphVision,
                    style: TextStyle(
                      fontFamily: 'abdoullah',
                      color: secondColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
