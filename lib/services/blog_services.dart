import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/posts_class.dart';

class BlogServices {
  //-----------------------GET-POSTS---------------------------------------
  Future<Posts?> fetchPosts() async {
    try {
      // Getting user token
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      // final result = await InternetAddress.lookup(baseUrl);
      // if (result.isNotEmpty && result[0].address.isNotEmpty) {
      var response = await http.get(
        Uri.https(baseUrl, postsRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // List<Datum>? postsList = [];
        var postsList = postsFromJson(response.body);
        return postsList;
      } else {
        // print('Couldn\'t get posts! ${response.statusCode}');
        return null;
      }
      // } else {
      //   // print('Address couldnt be looked at');
      //   return null;
      // }
    } catch (_) {
      // print(_);
      return null;
    }
  }

  //------------------------LIKE-POST---------------------------------------
  Future<bool> onLikeButtonTapped(
      bool isLiked, String id, BuildContext context) async {
    /// send your request here
    // final bool success= await sendRequest();

    try {
      // Getting user token
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if (isLiked == false) {
        final response = await http.get(
          Uri.https(
            baseUrl,
            "$likeRoute/$id",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          // print('$id LIKED = ${!isLiked}');
          AbySnackBar.successSnackbar(text: 'Your have liked a post');
          return !isLiked;
        } else {
          AbySnackBar.errorSnackbar(
              text: "Request failed with code ${response.statusCode}");
          return !isLiked;
        }
      } else {
        // print('$id UNLIKED = ${!isLiked}');
        return !isLiked;
      }
    } catch (e) {
      // print(e);
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return !isLiked;
    }

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
  }

  //------------------------COMMENT-----------------------------
  Future<bool> comment(String id, String comment, BuildContext context) async {
    try {
      // Getting user token
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      final response = await http.get(
        Uri.https(
          baseUrl,
          "$commentRoute/$id/$comment",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(
            text: 'Your comment has been sent successfully.');
        return true;
      } else {
        AbySnackBar.errorSnackbar(
            text: "Request failed with code ${response.statusCode}");
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request Failed.');
      return false;
    }
  }
}
