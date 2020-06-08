
import 'dart:convert';

import './post_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    http.Response  res= await http.get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }


Future<void> backPost(int id) async {
   http.Response res = await http.delete("$postsURL/$id");

  if (res.statusCode == 200) {
    print("BACK");
  } else {
    throw "Can't Back post.";
  }
}




}

 
