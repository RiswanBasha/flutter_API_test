import 'package:task_app/post.dart';

import './post_model.dart';
import 'package:flutter/material.dart';
import './http_service.dart';

class PostDetail extends StatefulWidget {
  //PostDetail({Key key}) : super(key: key);
  final Post post;

  PostDetail({@required this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text("Title"),
                      subtitle: Text(widget.post.title),
                    ),
                    ListTile(
                      title: Text("ID"),
                      subtitle: Text("${widget.post.id}"),
                    ),
                    ListTile(
                      title: Text("Body"),
                      subtitle: Text(widget.post.body),
                    ),
                    ListTile(
                      title: Text("User ID"),
                      subtitle: Text("${widget.post.userId}"),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                  child: Text('Back'),
                  onPressed: () {
                    setState(() {
                      httpService.backPost(widget.post.id);
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (context) => PostsPage(),
                        ),
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
