import 'package:flutter/material.dart';
import 'package:splash_screen_app/models/global_socket.dart';

class WebSocketScreen2 extends StatefulWidget {
  static const routeName = '/WebSocketScreen2';

  @override
  _WebSocketScreen2 createState() {
    return _WebSocketScreen2();
  }
}

class _WebSocketScreen2 extends State<WebSocketScreen2> {
  @override
  void initState() {
    var message = "Sending from Websocket Screen 2";
    sockets.sendSocket(message);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket 2'),
      ),
      body: ListView(
        children: <Widget>[Text('test')],
      ),
    );
  }
}
