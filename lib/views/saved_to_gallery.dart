import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meme_generator_app/services/upload_service.dart';

class SavedToGallery extends StatefulWidget {

  final bool isPublic;
  final String creator;
  final File image;

  SavedToGallery({@required this.image, @required this.isPublic, @required this.creator});

  @override
  _SavedToGalleryState createState() => _SavedToGalleryState();
}

class _SavedToGalleryState extends State<SavedToGallery> {

  UploadService uploadService = UploadService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => uploadService.uploadImage(widget.image, widget.isPublic, widget.creator));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          _resultText,
          _resultImage
        ],
      ),
    );
  }


  Widget get _resultText => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset('assets/animations/saved_to_gallery.json'),
        Text('ok'.tr(), style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('successMessage'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5),
        )
      ],
    ),
  );

  Widget get _resultImage => Image.file(widget.image);

}