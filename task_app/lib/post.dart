

import 'package:task_app/post_add.dart';

import './http_service.dart';
import './post_detail.dart';
import './post_model.dart';
import 'package:flutter/material.dart';
class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contents"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_comment),
            onPressed: () async {
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp1()));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (Post post) => ListTile(
                      title: Text(post.title),
                      subtitle: Text("${post.userId}"),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post: post,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}