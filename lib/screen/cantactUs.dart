import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  //The controls of Text Editing
  TextEditingController nameTextControl = TextEditingController();
  TextEditingController phoneTextControl = TextEditingController();
  TextEditingController messageTitleTextControl = TextEditingController();
  TextEditingController contentTextControl = TextEditingController();

  @override
  void dispose() {
    nameTextControl.dispose();
    phoneTextControl.dispose();
    messageTitleTextControl.dispose();
    contentTextControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text(
          'اتصل بنا ',
        ),
        backgroundColor: Color(0xffa257ba),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _contactUSCard(),
      ),
    );
  }

  Widget customTextField(
      String hitName, TextEditingController textEditingControl, int maxLine) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 8),
      child: Container(
          child: TextField(
        textAlign: TextAlign.right,
        maxLines: maxLine,
        controller: textEditingControl,
        decoration: InputDecoration(
          hoverColor: Color(0xff344672),
          focusColor: Color(0xff344672),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffa257ba),
            ),
          ),
          labelText: hitName,
          labelStyle: TextStyle(color: Color(0xff344672)),
        ),
      )),
    );
  }

  Widget _contactUSCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: Image.asset('assets/online_support_100px.png'),
            )),

        //name Of our Company or Brand
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 15, right: 7.7),
          child: Text(
            ':اتصل بنا                                                   ',
            style: TextStyle(
                color: Color(0xffa257ba),
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),

        customTextField('  ادخل الاسم', nameTextControl, 1),
        customTextField('رقم الهاتف', phoneTextControl, 1),
        customTextField('عنوان الرسالة', messageTitleTextControl, 1),
        customTextField('محتوى الرسالة', contentTextControl, 4),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width * 0.65,
            child: RaisedButton(
                onPressed: () {},
                color: Color(0xffa257ba),
                elevation: 2,
                child: FlatButton(
                  onPressed: () {
                    //Call Us via email
                    var myEmail = "abdessamed942@GMAIL.com";
                    String subject = messageTitleTextControl.text;
                    String body = "اسمي :" +
                        nameTextControl.text +
                        "\n " +
                        " رقم الهاتف : " +
                        phoneTextControl.text +
                        "\n " +
                        "محتوى الرسالة :" +
                        contentTextControl.text;
                    String mailUrl = Uri.encodeFull(
                        'mailto:$myEmail?subject=$subject&body=$body');
                    customURlLaunch(mailUrl);

                    nameTextControl.text = '';
                    phoneTextControl.text = '';
                    messageTitleTextControl.text = '';
                    contentTextControl.text = '';
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      Text(
                        'ارسل عبر الايمايل ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                )),
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
