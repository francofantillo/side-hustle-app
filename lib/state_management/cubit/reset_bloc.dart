import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

class RestBloc {
  /// Reset Blocs
  static Future resetBlocs({required BuildContext context}) async {
    final prefs = SharedPreferencesHelper.instance;

    final AuthCubit bloc = BlocProvider.of<AuthCubit>(context);

    /// clear shared
    await prefs.clearPreferences();

    /// Blocs
    await bloc.resetAuthBloc();
  }
}
