import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// get Request
Future<Response?> getRequestProvider(
    {required String path,
    String? token,
    Map<String, dynamic>? queryParameter}) async {
  late final Response response;
  const int timeout = 20000;

  try {
    if (token != null) {
      dio.options.connectTimeout = const Duration(milliseconds: timeout);
      response = await dio.get(path,
          queryParameters: queryParameter,
          options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              },
              sendTimeout: const Duration(milliseconds: timeout),
              receiveTimeout: const Duration(milliseconds: timeout)));
    } else {
      dio.options.connectTimeout = const Duration(milliseconds: timeout);
      response = await dio.get(path,
          options: Options(
              headers: {"Accept": "application/json"},
              sendTimeout: const Duration(milliseconds: timeout),
              receiveTimeout: const Duration(milliseconds: timeout)));
    }

    if (kDebugMode) {
      print("getRequestProvider response: ${response.data}");
    }

    return response;
  } on DioException catch (e) {
    print("*************************");
    print("getRequestProvider error: ${e.error}");
    print("getRequestProvider response error: ${e.response}");
    print("getRequestProvider status code: ${e.response?.statusCode}");
    print("DioException: ${e.response?.statusMessage}");
    print("*************************");
    return null;
    // if (e.error.toString().contains("SocketException")) {
    //   print("DioException: SocketException");
    //   // Utils.showToast(message: "No internet");
    //   return null;
    // }
    // if (e.response != null) {
    //   if (e.response!.statusCode == 401) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 400) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 500) {
    //     return e.response;
    //   } else {
    //     return e.response;
    //   }
    // } else {
    //   print("response is no internet null");
    //   return null;
    // }
  }
}

/// post Request
Future<Response?> postRequestProvider(
    {required String path, required data, String? token}) async {
  late final Response response;
  int timeout = 20000;

  try {
    if (token != null) {
      if ((path == API.UPDATE_RESUME)) {
        timeout = 3600000;
      }
      dio.options.connectTimeout = Duration(milliseconds: timeout);
      print("token not null $token}");
      response = await dio.post(path,
          data: data,
          options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              },
              sendTimeout: Duration(milliseconds: timeout),
              receiveTimeout: Duration(milliseconds: timeout)));
    } else {
      dio.options.connectTimeout = const Duration(milliseconds: 20000);
      response = await dio.post(path,
          data: data,
          options: Options(
              headers: {"Accept": "application/json"},
              sendTimeout: Duration(milliseconds: timeout),
              receiveTimeout: Duration(milliseconds: timeout)));
    }

    if (kDebugMode) {
      print("postRequestProvider response: $response");
    }

    return response;
  } on DioException catch (e) {
    if (kDebugMode) {
      print("*************************");
      print("postRequestProvider error: ${e.error}");
      print("postRequestProvider error response: ${e.response}");
      print("postRequestProvider error statusCode: ${e.response?.statusCode}");
      print("DioException: ${e.response?.statusMessage}");
      print("*************************");
    }
    return null;
    // if (e.response != null) {
    //   if (e.response!.statusCode == 401) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 400) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 500) {
    //     return e.response;
    //   } else {
    //     return e.response;
    //   }
    // } else {
    //   return null;
    // }
  }
}

/// put Request
Future<Response?> putRequestProvider(
    {required String path, required data, String? token}) async {
  late final Response response;
  const int timeout = 20000;

  try {
    if (token != null) {
      // if((path == API.ADD_MODULE) || path == API.EDIT_MODULE) {
      //   timeout = 3600000;
      // }
      dio.options.connectTimeout = const Duration(milliseconds: timeout);
      print("token not null $token}");
      response = await dio.put(path,
          data: data,
          options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              },
              sendTimeout: const Duration(milliseconds: timeout),
              receiveTimeout: const Duration(milliseconds: timeout)));
    } else {
      dio.options.connectTimeout = const Duration(milliseconds: 20000);
      response = await dio.put(path,
          data: data,
          options: Options(
              headers: {"Accept": "application/json"},
              sendTimeout: const Duration(milliseconds: timeout),
              receiveTimeout: const Duration(milliseconds: timeout)));
    }
    if (kDebugMode) {
      print("postRequestProvider response: $response");
    }

    return response;
  } on DioException catch (e) {
    if (kDebugMode) {
      print("**************************");
      print("postRequestProvider error: ${e.error}");
      print("postRequestProvider error response: ${e.response}");
      print("postRequestProvider error statusCode: ${e.response?.statusCode}");
      print("DioException: ${e.response?.statusMessage}");
      print("*************************");
    }
    return null;
    // if (e.response != null) {
    //   if (e.response!.statusCode == 401) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 400) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 500) {
    //     return e.response;
    //   } else {
    //     return e.response;
    //   }
    // } else {
    //   return null;
    // }
  }
}

/// delete Request
Future<Response?> deleteRequestProvider(
    {required String path,
    String? token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameter}) async {
  late final Response response;
  const int timeout = 20000;

  try {
    if (token != null) {
      dio.options.connectTimeout = const Duration(milliseconds: timeout);
      response = await dio.delete(path,
          data: data,
          queryParameters: queryParameter,
          options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              },
              sendTimeout: const Duration(milliseconds: timeout),
              receiveTimeout: const Duration(milliseconds: timeout)));
    } else {
      dio.options.connectTimeout = const Duration(milliseconds: timeout);
      response = await dio.delete(path,
          options: Options(headers: {"Accept": "application/json"}));
    }

    if (kDebugMode) {
      print("getRequestProvider response: ${response.data}");
    }

    return response;
  } on DioException catch (e) {
    if (kDebugMode) {
      print("*************************");
      print("deleteRequestProvider error: ${e.error}");
      print("deleteRequestProvider error response: ${e.response}");
      print("deleteRequestProvider status code: ${e.response?.statusCode}");
      print("DioException: ${e.response?.statusMessage}");
      print("*************************");
    }
    return null;
    // if (e.response != null) {
    //   if (e.response!.statusCode == 401) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 400) {
    //     return e.response;
    //   } else if (e.response!.statusCode == 500) {
    //     return e.response;
    //   } else {
    //     return e.response;
    //   }
    // } else {
    //   return null;
    // }
  }
}
