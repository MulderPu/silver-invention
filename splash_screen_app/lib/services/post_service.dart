import 'dart:convert';
import 'dart:io';

import 'package:splash_screen_app/models/global_post.dart';
import 'package:http/http.dart' as http;

String url = 'https://jsonplaceholder.typicode.com/posts';

String postToJson(Post data) {
  final dyn = data.toJson();

  print("encode dyn: ${json.encode(dyn)}");
  return json.encode(dyn);
}

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

Future<Post> fetchPost() async {
  final response =
      await http.get('$url/1');

  if (response.statusCode == 200) {
    print(response.body);
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

// Future<http.Response> sendPost(Post post) async{
//   final response = await http.post('$url',
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json',
//         // HttpHeaders.authorizationHeader : ''
//       },
//       body: postToJson(post)
//   );

//   return response;
// }

Future<Post> sendPost(Post post) async{
  final response = await http.post(Uri.encodeFull(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );

  return postFromJson(response.body);
}
