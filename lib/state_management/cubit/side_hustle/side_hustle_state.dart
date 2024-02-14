part of 'side_hustle_cubit.dart';

class SideHustleState {
  List<Images>? images;
  bool editProductLoading;
  bool editServiceLoading;
  YourShopModel? yourShopModel;
  bool yourShopLoading;
  bool isProductOrServiceFromHome;

  SideHustleState(
      {this.images,
      this.editProductLoading = false,
      this.editServiceLoading = false,
      this.yourShopModel,
      this.yourShopLoading = true,
      this.isProductOrServiceFromHome = false});

  SideHustleState copyWith(
      {List<Images>? images,
      bool? editProductLoading,
      bool? editServiceLoading,
      YourShopModel? yourShopModel,
      bool? yourShopLoading,
      bool? isProductOrServiceFromHome}) {
    return SideHustleState(
        images: images ?? this.images,
        editProductLoading: editProductLoading ?? this.editProductLoading,
        editServiceLoading: editServiceLoading ?? this.editServiceLoading,
        yourShopModel: yourShopModel ?? this.yourShopModel,
        yourShopLoading: yourShopLoading ?? this.yourShopLoading,
        isProductOrServiceFromHome:
            isProductOrServiceFromHome ?? this.isProductOrServiceFromHome);
  }
}
