import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meme_generator_app/constants/api.dart';
import 'package:meme_generator_app/services/upload_service.dart';
import 'package:meme_generator_app/views/image_preview.dart';
import 'package:meme_generator_app/widgets/button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class MyMemes extends StatelessWidget {
  BuildContext ctx;
  final UploadService uploadService = UploadService();

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return FutureBuilder(
        future: uploadService.getAllMemes(true), //with user id,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data.length > 0) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePreview(
                            memeId: snapshot.data[index].id,
                            isMyMeme: true,
                            imageUrl:
                                '$API_URL/${snapshot.data[index].imageUrl}'))),
                    child: Image.network(
                        '$API_URL/${snapshot.data[index].imageUrl}')),
              );
            } else {
              return _lookingEmpty;
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget get _lookingEmpty => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,          
          children: <Widget>[
            Lottie.asset('assets/animations/empty.json'),
            Text('noMemeYet'.tr(), style: Theme.of(ctx).textTheme.headline4),
            DefaultButton(
              color: Colors.indigo,
              textColor: Colors.white,
              child: Text('createOne'.tr()),
              onPressed: () {},
            )
          ],
        ),
      );
}
