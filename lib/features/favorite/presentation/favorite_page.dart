import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/favorite/domain/favorite_repository.dart';
import 'package:tea_list/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:tea_list/features/favorite/presentation/favorite_screen.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;
    return BlocProvider(
      create:
          (context) => FavoriteBloc(favoriteRepository: getIt<FavoriteRepository>())..add(TryFetchFavoriteTeasEvent()),
      child: FavoriteScreen(),
    );
  }
}
