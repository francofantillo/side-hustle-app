import 'dart:io';

import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:path/path.dart' as getImagePath;

var dio = Dio();

/// Add Product
Future<Response?> addProductProvider(
    {List<File>? images,
    String? name,
    String? price,
    int? isShopLocation,
    String? deliveryType,
    String? location,
    String? lat,
    String? lng,
    String? description,
    String? zipCode,
    String? additionalInformation,
    String? planId,
    String? apiToken}) async {
/*  type:Service
  name:My NEW Service
//price:14.99
//delivery_type:fixed
  location:"test location"
  lat:124.021548754
  lng:245.365845
  description:Test Description
  zip_code:75950
  additional_information:Additional information
  plan_id:3
  service_type:Hourly
  hourly_rate:14.99*/
  late final Map<String, dynamic> productData;

  print("images $images");
  if (images != null && images.isNotEmpty) {
    final List<MultipartFile> imageList = [];
    for (int i = 0; i < images.length; i++) {
      final imageNetwork = await MultipartFile.fromFile(images[i].path,
          filename: getImagePath.basename(images[i].path));
      imageList.add(imageNetwork);
      print("Images Multipart $i: ${imageList[i]}\npath: ${images[i].path}");
    }
    print(
        "images length: ${images.length}, Images Multipart Length: ${imageList.length}");

    productData = {
      "type": SideHustleTypeEnum.Product.name,
      "images[]": imageList,
      "is_shop_location": isShopLocation,
      "name": name,
      "price": price,
      "delivery_type": deliveryType,
      "location": location,
      "lat": lat,
      "lng": lng,
      "description": description,
      "zip_code": zipCode,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  } else {
    productData = {
      "type": SideHustleTypeEnum.Product.name,
      "is_shop_location": isShopLocation,
      "name": name,
      "price": price,
      "delivery_type": deliveryType,
      "location": location,
      "lat": lat,
      "lng": lng,
      "description": description,
      "zip_code": zipCode,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  }

  final data = FormData.fromMap(productData);

  print(
      "*****************\nurl: ${API.ADD_PRODUCT_OR_SERVICE}\ndata: $productData\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_PRODUCT_OR_SERVICE, data: data, token: apiToken);
  return response;
}

/// Add Service
Future<Response?> addServiceProvider(
    {List<File>? images,
    String? isShopLocation,
    String? name,
    String? hourlyRate,
    String? serviceType,
    String? locationAddress,
    String? lat,
    String? lng,
    String? description,
    String? additionalInformation,
    String? planId,
    String? apiToken}) async {
  late final Map<String, dynamic> serviceData;

  print("images $images");
  if (images != null && images.isNotEmpty) {
    final List<MultipartFile> imageList = [];
    for (int i = 0; i < images.length; i++) {
      final imageNetwork = await MultipartFile.fromFile(images[i].path,
          filename: getImagePath.basename(images[i].path));
      imageList.add(imageNetwork);
      print("Images Multipart $i: ${imageList[i]}\npath: ${images[i].path}");
    }
    print(
        "images length: ${images.length}, Images Multipart Length: ${imageList.length}");

    serviceData = {
      "type": SideHustleTypeEnum.Service.name,
      "images[]": imageList,
      "is_shop_location": isShopLocation,
      "name": name,
      "hourly_rate": hourlyRate,
      "service_type": serviceType,
      "location": locationAddress,
      "lat": lat,
      "lng": lng,
      "description": description,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  } else {
    serviceData = {
      "type": SideHustleTypeEnum.Service.name,
      "is_shop_location": isShopLocation,
      "name": name,
      "hourly_rate": hourlyRate,
      "service_type": serviceType,
      "location": locationAddress,
      "lat": lat,
      "lng": lng,
      "description": description,
      "additional_information": additionalInformation,
      "plan_id": planId
    };
  }

  final data = FormData.fromMap(serviceData);

  print(
      "*****************\nurl: ${API.ADD_PRODUCT_OR_SERVICE}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_PRODUCT_OR_SERVICE, data: data, token: apiToken);
  return response;
}

/// Get Your Shop
Future<Response?> getYourShopProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.GET_YOUR_SHOP}\n**************************");
  final response =
      await getRequestProvider(path: API.GET_YOUR_SHOP, token: apiToken);
  return response;
}
