part of 'side_hustle_cubit.dart';

class SideHustleState {
  List<Images>? images;
  bool editProductLoading;
  bool editServiceLoading;
  YourShopModel? yourShopModel;
  bool yourShopLoading;
  YourShopModel? otherUserShopModel;
  bool otherUserShopLoading;
  bool isProductOrServiceFromYourShop;
  GetEditSideHustleModel? editSideHustleModel;
  bool editSideHustleLoading;
  SideHustleModel? sideHustleModel;
  bool sideHustleLoading;
  List<SideHustleData>? sideHustleTempList;
  bool searching;
  SideHustleDetailModel? sideHustleDetailModel;
  bool sideHustleDetailLoading;
  CartModel? cartModel;
  bool cartLoading;
  String? deliveryAddressCart;

  SideHustleState(
      {this.images,
      this.editProductLoading = false,
      this.editServiceLoading = false,
      this.otherUserShopModel,
      this.otherUserShopLoading = true,
      this.yourShopModel,
      this.yourShopLoading = true,
      this.isProductOrServiceFromYourShop = false,
      this.editSideHustleModel,
      this.editSideHustleLoading = false,
      this.sideHustleModel,
      this.sideHustleLoading = true,
      this.sideHustleTempList,
      this.searching = false,
      this.sideHustleDetailModel,
      this.sideHustleDetailLoading = true,
      this.cartModel,
      this.cartLoading = false,
      this.deliveryAddressCart});

  SideHustleState copyWith(
      {List<Images>? images,
      bool? editProductLoading,
      bool? editServiceLoading,
      YourShopModel? yourShopModel,
      bool? yourShopLoading,
      YourShopModel? otherUserShopModel,
      bool? otherUserShopLoading,
      bool? isProductOrServiceFromYourShop,
      GetEditSideHustleModel? editSideHustleModel,
      bool? editSideHustleLoading,
      SideHustleModel? sideHustleModel,
      bool? sideHustleLoading,
      List<SideHustleData>? sideHustleTempList,
      bool? searching,
      SideHustleDetailModel? sideHustleDetailModel,
      bool? sideHustleDetailLoading,
      CartModel? cartModel,
      bool? cartLoading,
      String? deliveryAddressCart}) {
    return SideHustleState(
        images: images ?? this.images,
        editProductLoading: editProductLoading ?? this.editProductLoading,
        editServiceLoading: editServiceLoading ?? this.editServiceLoading,
        yourShopModel: yourShopModel ?? this.yourShopModel,
        yourShopLoading: yourShopLoading ?? this.yourShopLoading,
        otherUserShopModel: otherUserShopModel ?? this.otherUserShopModel,
        otherUserShopLoading: otherUserShopLoading ?? this.otherUserShopLoading,
        isProductOrServiceFromYourShop:
            isProductOrServiceFromYourShop ?? this.isProductOrServiceFromYourShop,
        editSideHustleModel: editSideHustleModel ?? this.editSideHustleModel,
        editSideHustleLoading:
            editSideHustleLoading ?? this.editSideHustleLoading,
        sideHustleModel: sideHustleModel ?? this.sideHustleModel,
        sideHustleLoading: sideHustleLoading ?? this.sideHustleLoading,
        sideHustleTempList: sideHustleTempList ?? this.sideHustleTempList,
        searching: searching ?? this.searching,
        sideHustleDetailModel:
            sideHustleDetailModel ?? this.sideHustleDetailModel,
        sideHustleDetailLoading:
            sideHustleDetailLoading ?? this.sideHustleDetailLoading,
        cartModel: cartModel ?? this.cartModel,
        cartLoading: cartLoading ?? this.cartLoading,
        deliveryAddressCart: deliveryAddressCart ?? this.deliveryAddressCart);
  }
}
