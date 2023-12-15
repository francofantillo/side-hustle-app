part of 'favourites_cubit.dart';

class FavouritesState {
  FavouritesModel? favouritesModel;
  bool favouritesModelLoading;

  FavouritesState({this.favouritesModel, this.favouritesModelLoading = true});

  FavouritesState copyWith(
      {FavouritesModel? favouritesModel, bool? favouritesModelLoading}) {
    return FavouritesState(
        favouritesModel: favouritesModel ?? this.favouritesModel,
        favouritesModelLoading:
            favouritesModelLoading ?? this.favouritesModelLoading);
  }
}
