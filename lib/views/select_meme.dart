import 'package:flutter/material.dart';
import 'package:meme_generator_app/services/upload_service.dart';
import 'package:meme_generator_app/views/guide.dart';
import 'package:meme_generator_app/widgets/meme_templates.dart';
import 'package:meme_generator_app/widgets/memes.dart';
import 'package:meme_generator_app/widgets/my_memes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectMeme extends StatefulWidget {
  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  UploadService uploadService = UploadService();
  int currentIndex = 0;

  askStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print('already greanted');
    }
  }

  List<Widget> widgets = [
    MemeTemplates(memes: [
      'assets/memes/meme-1.jpg',
      'assets/memes/meme-2.jpeg',
      'assets/memes/meme-3.jpg',
      'assets/memes/meme-4.jpg',
      'assets/memes/meme-5.webp',
      'assets/memes/meme-6.jpg',
      'assets/memes/meme-7.jpg',
      'assets/memes/meme-8.webp',
      'assets/memes/meme-9.png',
      'assets/memes/meme-10.jpg',
    ]),
    Memes(),
    MyMemes()
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      askStoragePermission();
      uploadService.getUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo), title: Text('templates').tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), title: Text('memes').tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('myMemes').tr()),
        ],
      ),
      body: widgets[currentIndex],
    );
  }

  Widget get _appBar => AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: 'Guide',
            icon: Icon(Icons.info),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Guide())),
          )
        ],
        elevation: 0,
        centerTitle: true,
        title: Text(currentIndex == 0
            ? 'Templates'.tr()
            : currentIndex == 2 ? 'myMemes'.tr() : 'memes'.tr()),
      );
}
