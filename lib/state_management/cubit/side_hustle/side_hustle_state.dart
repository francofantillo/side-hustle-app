part of 'side_hustle_cubit.dart';

class SideHustleState {
  List<Images>? images;
  bool editProductLoading;
  bool editServiceLoading;
  YourShopModel? yourShopModel;
  bool yourShopLoading;
  bool isProductOrServiceFromHome;
  GetEditSideHustleModel? editSideHustleModel;
  bool editSideHustleLoading;

  SideHustleState(
      {this.images,
      this.editProductLoading = false,
      this.editServiceLoading = false,
      this.yourShopModel,
      this.yourShopLoading = true,
      this.isProductOrServiceFromHome = false,
      this.editSideHustleModel,
      this.editSideHustleLoading = false});

  SideHustleState copyWith(
      {List<Images>? images,
      bool? editProductLoading,
      bool? editServiceLoading,
      YourShopModel? yourShopModel,
      bool? yourShopLoading,
      bool? isProductOrServiceFromHome,
      GetEditSideHustleModel? editSideHustleModel,
      bool? editSideHustleLoading}) {
    return SideHustleState(
        images: images ?? this.images,
        editProductLoading: editProductLoading ?? this.editProductLoading,
        editServiceLoading: editServiceLoading ?? this.editServiceLoading,
        yourShopModel: yourShopModel ?? this.yourShopModel,
        yourShopLoading: yourShopLoading ?? this.yourShopLoading,
        isProductOrServiceFromHome:
            isProductOrServiceFromHome ?? this.isProductOrServiceFromHome,
        editSideHustleModel: editSideHustleModel ?? this.editSideHustleModel,
        editSideHustleLoading:
            editSideHustleLoading ?? this.editSideHustleLoading);
  }
}
