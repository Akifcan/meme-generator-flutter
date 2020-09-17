import 'dart:io';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:dio/dio.dart';
import 'package:meme_generator_app/constants/api.dart';
import 'package:meme_generator_app/models/meme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadService{

  getUserId() async {
    ObjectId objectId = ObjectId();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString('userId') == null){
      preferences.setString('userId', objectId.toHexString());
      print('created!');
      print(preferences.getString('userId'));
    }else{
      print(preferences.getString('userId'));
    }
  }

 uploadImage(File file, bool isPublic, String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
        "userId": preferences.getString('userId'),
        "isPublic": isPublic,
        "creator": name,
        "image":
            await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response =  await dio.post("$API_URL/upload-meme", data: formData);
    print(response.data);
    }

   Future<List<Meme>>  getAllMemes(bool withUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<Meme> memes = [];
    Dio dio = Dio();
    var response = await dio.get(!withUserId ? '$API_URL/memes' : '$API_URL/memes/${preferences.getString('userId')}');
    List result = response.data;
    memes = result.map((meme) => Meme.fromJson(meme)).toList();
    print(memes);
    return memes;
  }

  deleteMeme(String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString('userId');
    Dio dio = Dio();
    var response = await dio.delete('$API_URL/meme/$userId/$id');
    print(response.data);
    return response.data['status'];
  }

}





