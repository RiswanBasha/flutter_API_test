import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/post.dart';

Future<Album> createAlbum(String title, String value) async {
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/albums',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'value': value,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  }
   else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;
  final String value;

  Album({this.id, this.title, this.value});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      value: json['value'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _bodycontroller = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Post '),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null)
              ? Column(
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          hintText: 'Enter Title', labelText: 'Post Title'),
                    ),
                    TextField(
                      controller: _bodycontroller,
                      decoration: InputDecoration(
                          hintText: 'Enter Value', labelText: 'Post Value'),
                    ),
                    RaisedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState( () {
                          _futureAlbum = createAlbum(
                              _controller.text, _bodycontroller.text);
                        }
                        );
                      },
                    ),
                  ],
                )
              : FutureBuilder<Album>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          child: Column(
                            children: <Widget>[
                              Card(
                                margin: EdgeInsets.all(12),
                                child: Column(
                                  children: <Widget>[
                          ListTile(
                            title: Text('TITLE:',style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),),
                            subtitle: Text(
                              snapshot.data.title,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),

                          ),
                          ListTile(
                            title: Text('BODY:',style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),),
                            subtitle:Text(
                              snapshot.data.value,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                                  ],
                                ),
                              ),
                              RaisedButton(
                        child: Text('Back'),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostsPage(),
                              ),
                            );
                          });
                        }),
                            ],
                      )
                      );
                    }
                     else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
