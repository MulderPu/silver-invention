import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splash_screen_app/models/global_post.dart';
import 'package:splash_screen_app/services/post_service.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  static const routeName = '/DetailScreen';

  @override
  _DetailScreenState createState() => new _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<Post> post;
  // Future<http.Response> _response;
  Future<Post> _response;

  @override
  void initState() {
    super.initState();
    // post = fetchPost();
    Post postData =
        Post(body: 'Testing body body body', title: 'Flutter jam6');
    _response = sendPost(postData);
  }

  @override
  Widget build(BuildContext context) {
    // extract arguments
    final DetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text('Name: ${args.name}'),
          Text('Decription: ${args.description}'),
          const SizedBox(height: 20),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'),
            ),
          ),
          Center(
            // child: FutureBuilder<Post>(
            //   future: post,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data.title);
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }

            //     // By default, show a loading spinner.
            //     return CircularProgressIndicator();
            //   },
            // ),
            child: FutureBuilder<Post>(
              future: _response,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return Text(jsonDecode(snapshot.data));
                  return Text(snapshot.data.title);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}

class DetailArguments {
  final String name;
  final String description;

  DetailArguments(this.name, this.description);
}
