import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

class ClearAppData {
  /// Reset Blocs
  static Future resetBlocs({required BuildContext context}) async {
    final prefs = SharedPreferencesHelper.instance;

    final AuthCubit bloc = BlocProvider.of<AuthCubit>(context);
    final CardCubit blocCard = BlocProvider.of<CardCubit>(context);
    final EventsCubit blocEvents = BlocProvider.of<EventsCubit>(context);
    final FavouritesCubit blocFavourites = BlocProvider.of<FavouritesCubit>(context);

    /// clear shared
    await prefs.clearPreferences();

    /// Blocs
    await bloc.resetAuthBloc();
    await blocCard.resetCardBloc();
    await blocEvents.resetEventsBloc();
    await blocFavourites.resetFavouritesBloc();
  }
}
