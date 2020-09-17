import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class Guide extends StatefulWidget {
  Guide({Key key}) : super(key: key);

  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  PageController pageController = PageController();
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    print(context.locale == Locale('tr', 'TR'));
    String locale = context.locale == Locale('tr', 'TR') ? 'tr' : 'en';
    return Scaffold(
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: Tooltip(
              message: 'Geri',
              child: GestureDetector(
                onTap: () {
                  if (currentIndex != 0) {
                    currentIndex -= 1;
                  } else {
                    currentIndex = 5;
                  }
                  pageController.animateToPage(currentIndex,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                },
                child: Container(
                  color: Colors.indigo,
                  height: 40,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Tooltip(
              message: 'İleri',
              child: GestureDetector(
                onTap: () {
                  if (currentIndex != 5) {
                    currentIndex += 1;
                  } else {
                    currentIndex = 0;
                  }
                  pageController.animateToPage(currentIndex,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                },
                child: Container(
                  color: Colors.indigo,
                  height: 40,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: <Widget>[
            Image.asset('assets/guides/style-$locale.png',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center),
            Image.asset('assets/guides/drag-$locale.png',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center),
            Image.asset('assets/guides/delete-$locale.png',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center),
            Image.asset('assets/guides/add-new-$locale.png',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async{
                      launch('https://lottiefiles.com/10575-storage-permissions');
                    },
                    child: Text('Save to gallery anmiation by: LottieFiles')),
                  GestureDetector(
                    onTap: () async => launch('https://lottiefiles.com/31038-empty-state-boo'),
                    child: Text('Empty memes animations by: Hanan ')),
                  GestureDetector(
                    onTap: () async => launch('https://www.flaticon.com/free-icon/laugh_2058208?term=fun&page=1&position=24'),
                    child: Text('App icon by: freepik ')),
                  Image.asset('assets/icons/app-icon-by-freepik.png',
                      height: 150),
                  SizedBox(height: 50),
                  Text('Meme Generator | With Templates',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async => launch('https://sea-api.herokuapp.com/'),
                                      child: Text('Sea',
                        style: GoogleFonts.play(
                            fontSize: 26, color: Color(0xff006994))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
