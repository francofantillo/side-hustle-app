import 'dart:developer';

import 'package:side_hustle/state_management/service/socket_navigation.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static Socket? _socket;

  SocketService._();

  static SocketService? _instance;

  static SocketService? get instance {
    if (_instance == null) {
      _instance = SocketService._();
    }
    return _instance;
  }

  Socket? get socket => _socket;

  void initializeSocket() {
    // _socket = io(API.CHAT_SOCKET_API_BASE_URL, <String, dynamic>{
    //   'autoConnect': false,
    //   'transports': ['websocket'],
    // });
    _socket = IO.io(
        API.CHAT_SOCKET_API_BASE_URL,
        OptionBuilder()
            // .setPath('/rt')
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableReconnection()
            .setExtraHeaders({
              'Connection': 'Upgrade',
            })
            .enableForceNew()
            .build());
  }

  void connectSocket() {
    _socket?.connect();

    _socket?.on("connect", (data) {
      //   AppDialogs.showToast(message: 'Connected socket $data');
      log('Connected socket ');
      // checkSocketConnection(true);
    });

    _socket?.on("disconnect", (data) {
      // AppDialogs.showToast(message: 'Disconnected socket $data');
      log('Disconnected ' + data.toString());
    });

    _socket?.on("connect_error", (data) {
      log('Connect Error ' + data.toString());
    });

    _socket?.on("error", (data) {
      //log('Error ' + data.toString());
      SocketNavigationClass.instance
          ?.socketErrorMethod(errorResponseData: data);
    });

    //log("Socket Connect:${socket?.connected}");
  }

  void socketEmitMethod(
      {required String eventName, required dynamic eventParameters}) {
    /// Send Message
    final data = {"chat_id": 3, "receiver_id": 4, "sender_id": 5};

    _socket?.emit(eventName, eventParameters);
  }

  // void connectUser() async {
  //   if (socket?.connected == true) {
  //     final _bloc =
  //     BlocProvider.of<ChatCubit>(BaseWidget.globalKey.currentContext!);
  //     final UserModel? userModel = await _bloc.getUserData();
  //     int? uId = userModel?.data?.id;
  //     final json = {
  //       "user_id": uId,
  //       "user_model": "Seller", /// Seller or Buyer
  //       "receiver_id": "",
  //       "chat_id": ""
  //     };
  //
  //     /// connect users
  //     socket?.emit('connect_user', json);
  //     socket?.on('connect_user', (data) {
  //       print("LISTENING TO EVENT 'connect_user' $data");
  //       // listenToMessage();
  //     });
  //   }
  // }

  void socketResponseMethod() {
    // _socket?.on("response", (data) {
    //   SocketNavigationClass.instance?.socketResponseMethod(responseData: data);
    // });
    _socket?.on(API.GET_MESSAGE_KEY, (data) {
      SocketNavigationClass.instance?.socketResponseMethod(responseData: data);
    });

    // _socket?.on(API.CONNECT_USER_KEY, (data) {
    // SocketNavigationClass.instance?.socketResponseMethod(responseData: data);
    // });
  }

  void dispose() {
    _socket?.dispose();
  }
}
