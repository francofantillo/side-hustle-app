import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/utils/api_path.dart';

class SocketNavigationClass {
  static SocketNavigationClass? _instance;

  SocketNavigationClass._();

  static SocketNavigationClass? get instance {
    _instance ??= SocketNavigationClass._();
    return _instance;
  }

  void socketResponseMethod(
      {dynamic responseData, Function(String? value)? onSuccess}) {
    // int? userId=Provider.of<UserProvider>(StaticData.navigatorKey.currentContext!,listen: false).getCurrentUser?.data!.id;
    // print("respnseData: $responseData");
    log("responseData is " + responseData.toString());

    if (responseData != null) {
      final bloc =
          BlocProvider.of<ChatCubit>(BaseWidget.globalKey.currentContext!);

      bloc.appendSingleMessage(singleMessage: responseData);

      if (responseData["object_type"] == API.GET_MESSAGES_KEY) {
        // bloc.setChatData(chatDataList: responseData);
      } else if (responseData["object_type"] == API.GET_MESSAGE_KEY) {
        print("bloc conditissson");
        // bloc.appendSingleMessage(singleMessage: responseData);
      }
    }
  }

  void socketErrorMethod({dynamic errorResponseData}) {
    print("errorResponseData: $errorResponseData");
    if (errorResponseData != null) {
      if (errorResponseData["object_type"] == API.GET_MESSAGES_KEY) {}
    }
  }
}
