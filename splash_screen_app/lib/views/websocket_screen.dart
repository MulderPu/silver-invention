import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splash_screen_app/views/websocket_screen_2.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:splash_screen_app/models/global_socket.dart';

class WebSocketScreen extends StatefulWidget {
  static const routeName = '/WebSocketScreen';

  @override
  _WebSocketScreen createState() {
    return new _WebSocketScreen();
  }
}

class _WebSocketScreen extends State<WebSocketScreen> {
  WebSocketChannel channel;
  TextEditingController _controller = TextEditingController();
  var messagesFromServer = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    sockets.initSocket();

    sockets.addListener(_onMessageReceived);
  }

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text('Test websocket ...'),
          spacing,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send a message'),
                ),
              ),
              // StreamBuilder(
              //   stream: channel.stream,
              //   builder: (context, snapshot) {
              //     print(snapshot);

              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 24.0),
              //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              //     );
              //   },
              // )
              Text(messagesFromServer),
            ],    
          ),
          spacing,
          RaisedButton(
            child: Text('Go to Websocket 2'),
            onPressed: () {
              // go to websocket 2nd screen
              Navigator.pushNamed(context, WebSocketScreen2.routeName);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // channel.sink.add(_controller.text);
      var message = _controller.text;
      sockets.sendSocket(message);
    }
  }

  @override
  void dispose() {
    print('close socket');
    // channel.sink.close();
    sockets.removeListener(_onMessageReceived);
    sockets.closeSocket();
    super.dispose();
  }

  _onMessageReceived(serverMessage) {
    messagesFromServer = serverMessage;

    // force rebuild
    setState(() {
      
    });
    print("Screen message: $serverMessage");
  }
}
