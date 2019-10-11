import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

// global variables to access websockets
WebSocketsNotifications sockets = new WebSocketsNotifications();

const String _SERVER_ADDRESS = "ws://echo.websocket.org";

/// This class is a Singleton that handles websockets.
/// Purpose:
/// - allow it to reuse everywhere.
class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      new WebSocketsNotifications._internal();

  factory WebSocketsNotifications() {
    return _sockets;
  }

  WebSocketsNotifications._internal();

  /// socket channel
  IOWebSocketChannel _channel;

  /// socket connection
  bool _socketStarted = false;

  /// Listeners
  /// List of methods to be called when a new message comes in.
  ObserverList<Function> _listeners = new ObserverList<Function>();

  initSocket() async {
    closeSocket(); // close any previous socket if any

    /// open socket
    try {
      print('open socket');

      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS);

      // listen socket
      _channel.stream.listen(_messageFromServer);

      ///
      ///
      ///
      ///assume true for now
      _socketStarted = true;
    } catch (e) {
      print("Error: $e");
      /// TODO: error handling
      /// 
      /// 
    }
  }

  /// Close socket connection
  void closeSocket() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
        _socketStarted = false;
      }
    }
  }

  /// Send message to socket
  void sendSocket(String message) {
    if (_channel != null) {
      print(_socketStarted);
      if(_channel.sink != null && _socketStarted) {
        print('send: $message');
        
        _channel.sink.add(message);
      }
    }
  }

  /// Callback which is invoked each time when receiving message from server
  void _messageFromServer(serverMessage) {
    print("Server Message: $serverMessage");

    _socketStarted = true;
    _listeners.forEach((Function callback) {
      callback(serverMessage);
    });
  }

  ///
  /// Add function to callback listener if has incoming message
  ///
  void addListener(Function callback) {
    _listeners.add(callback);
  }

  void removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
