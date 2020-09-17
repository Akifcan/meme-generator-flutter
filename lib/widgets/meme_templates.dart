import 'package:flutter/material.dart';
import 'package:meme_generator_app/views/edit-meme/edit_meme.dart';

class MemeTemplates extends StatelessWidget {
  final List<String> memes;

  MemeTemplates({@required this.memes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: memes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 13, crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditMeme(selectedMeme: memes[index]))),
            child: Image.asset(memes[index])));
  }
}
