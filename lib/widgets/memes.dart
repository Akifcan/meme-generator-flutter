import 'package:flutter/material.dart';
import 'package:meme_generator_app/constants/api.dart';
import 'package:meme_generator_app/services/upload_service.dart';
import 'package:meme_generator_app/views/image_preview.dart';

class Memes extends StatelessWidget {
  final UploadService uploadService = UploadService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: uploadService.getAllMemes(false), //with user id,
        builder: (context, snapshot) => snapshot.hasData
            ? GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePreview(
                          memeId: snapshot.data[index].id,
                          isMyMeme: false,
                            imageUrl:
                                '$API_URL/${snapshot.data[index].imageUrl}'))),
                    child: Image.network(
                        '$API_URL/${snapshot.data[index].imageUrl}')),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
