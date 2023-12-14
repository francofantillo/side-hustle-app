import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Change Password
Future<Response?> addProductOrServiceProvider(
    {required bool isProduct,
    String? type,
    String? name,
    String? price,
    String? deliveryType,
    String? locationAddress,
    String? lat,
    String? lng,
    String? description,
    String? zipCode,
    String? additionalInformation,
    String? planId,
    String? apiToken}) async {

  /*
  type:Product
name:My NEW Product
price:20.5
delivery_type:fixed
location:"test location"
lat:124.021548754
lng:245.365845
description:Test Description
zip_code:98765
additional_information:Additional information
plan_id:3
   */

  late final Map<String, dynamic> productData;
  late final Map<String, dynamic> serviceData;
  if (isProduct) {
    productData = {
      "type": type,
      "name": name,
      "price": price,
      "delivery_type": deliveryType,
      "location": locationAddress,
      "lat": lat,
      "lng": lng,
      "description": description,
      "zip_code": zipCode,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  } else {
    serviceData = {
      "type": type,
      "name": name,
      "price": price,
      "delivery_type": deliveryType,
      "location": locationAddress,
      "lat": lat,
      "lng": lng,
      "description": description,
      "zip_code": zipCode,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  }

  final data = FormData.fromMap(isProduct ? productData : serviceData);

  print(
      "*****************\nurl: ${API.ADD_PRODUCT_OR_SERVICE}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_PRODUCT_OR_SERVICE, data: data, token: apiToken);
  return response;
}
