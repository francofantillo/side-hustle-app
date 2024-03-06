import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final prefs = SharedPreferencesHelper.instance;

  static late IO.Socket _socket;

  static const String socketPort = '3014';
  static const String socketURL =
      // "http://your_server_address:$socketPort";
      "https://socketside-hustle.trangotech.dev";

  static void init() {
    // Initialize the Socket.IO connection
    _socket = IO.io(socketURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Define socket event handlers
    _socket.onConnect((_) {
      print('Connected to server');
    });

    _socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    _socket.on('message', (data) {
      print('Received message: $data');
    });

    // Connect to the server
    _socket.connect();
  }

  static IO.Socket get socket => _socket;

  static void sendMessage(String message) {
    // Send a message to the server
    _socket.emit('message', message);
  }

  static void dispose() {
    // Disconnect from the server when the app is closed or no longer needs the socket
    _socket.disconnect();
  }

  static connectUser() async {
    if (socket.connected == true) {
      int? currentUserId = await getCurrentUserId();
      final json = {
        "user_id": currentUserId,
        "user_model": "",
      };

      socket.emit('connect_user', json);
    }
  }

  static Future<int> getCurrentUserId() async {
    final UserModel? userModel = await prefs.getUser();
    return userModel?.data?.id ?? 0;
  }
}
