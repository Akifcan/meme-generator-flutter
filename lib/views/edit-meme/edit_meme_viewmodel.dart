import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:meme_generator_app/models/text_info.dart';
import 'package:meme_generator_app/views/edit-meme/edit_meme.dart';
import 'package:meme_generator_app/views/saved_to_gallery.dart';
import 'package:meme_generator_app/widgets/button/default_button.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditMemeViewModel extends State<EditMeme> {
  TextEditingController text = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  bool isPublic = true;
  bool addName = false;

  List<TextInfo> texts = [];
  int currentIndex = 0;

  save() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Text('save'.tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('isPublic'.tr()),
                      Switch(
                        value: isPublic,
                        onChanged: (bool value) =>
                            setState(() => isPublic = value),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('name'.tr()),
                      Checkbox(
                        onChanged: (bool value) =>
                            setState(() => addName = value),
                        value: addName,
                      )
                    ],
                  ),
                  addName
                      ? TextField(
                          controller: creatorText,
                          decoration: InputDecoration(
                              filled: true, hintText: 'nameHint'.tr()),
                        )
                      : SizedBox.shrink(),
                  Container(
                    width: double.infinity,
                    child: DefaultButton(
                      child: Text('saveMeme'.tr()),
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.of(context).pop();
                        saveToGallery();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  saveToGallery() {
    if (texts.length > 0) {
      screenshotController.capture().then((File image) {
        GallerySaver.saveImage(image.path).then((var result) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SavedToGallery(image: image, isPublic: isPublic, creator: creatorText.text)));
        });
      }).catchError((onError) {
        print(onError);
      });
    } else {
      Fluttertoast.showToast(
          msg: 'noText'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });
    Fluttertoast.showToast(
        msg: 'selectedForStyling'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  removeText() {
    setState(() {
      texts.removeAt(currentIndex);
    });
    Fluttertoast.showToast(
        msg: 'deleted'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
      print(texts[currentIndex].textAlign);
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(' ', '\n');
    });
  }

  addNewText() {
    setState(() {
      texts.add(TextInfo(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          text: text.text,
          textAlign: TextAlign.left,
          fontSize: 20,
          left: 0,
          top: 0));
    });
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('addNewText'.tr()),
              content: TextField(
                controller: text,
                maxLines: 5,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    filled: true,
                    hintText: 'addTextHint'.tr()),
              ),
              actions: <Widget>[
                DefaultButton(
                  onPressed: addNewText,
                  child: Text('addNewText'.tr()),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
                DefaultButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('back'.tr()),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            ));
  }
}
