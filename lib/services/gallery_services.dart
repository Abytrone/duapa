import 'package:duapa/models/gallery_picture_class.dart';
import 'package:duapa/services/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gallery_video_class.dart';

class GalleryServices {
  Future<List<GalleryVideo>> getVideos() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse('https://$baseUrl$videosRoute');
    final response = await http.get(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return galleryVideoFromJson(response.body);
  }

  Future<GalleryPictures> getPictures() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse('https://$baseUrl$galleryRoute');
    final response = await http.get(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return galleryFromJson(response.body);
  }
}
