import 'package:flutter/material.dart';

class Meme{
  final String id;
  final String userId;
  final String imageUrl;

  Meme({@required this.id, @required this.userId, @required this.imageUrl});

  factory Meme.fromJson(Map json){
    return Meme(
      id: json['_id'],
      userId: json['userId'],
      imageUrl: json['imageUrl']
    );
  }

}