import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:meme_generator_app/services/upload_service.dart';
import 'package:meme_generator_app/widgets/button/default_button.dart';
import 'package:meme_generator_app/widgets/my_memes.dart';
import 'package:easy_localization/easy_localization.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final bool isMyMeme;
  final String memeId;
  final UploadService uploadService = UploadService();
  ImagePreview(
      {@required this.imageUrl,
      @required this.isMyMeme,
      @required this.memeId});

  deleteImage(context) async {
    var result = await uploadService.deleteMeme(this.memeId);
    if (result) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyMemes()));
      Fluttertoast.showToast(
          msg: 'deletedMeme'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  downloadImage(context) async {
    await ImageDownloader.downloadImage(this.imageUrl);
    Fluttertoast.showToast(
        msg: 'downloadedMeme'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showChoices(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('choices'.tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  isMyMeme
                      ? InkWell(
                          onTap: () => deleteImage(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('deleteChoice'.tr()),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () => downloadImage(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('downloadChoice'.tr()),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                DefaultButton(
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: Colors.white,
                  child: Text('back'.tr()),
                  color: Colors.indigo,
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => showChoices(context),
          child: Image.network(this.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill)),
    );
  }
}
