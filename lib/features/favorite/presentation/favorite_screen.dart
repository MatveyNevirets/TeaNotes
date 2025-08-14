import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 64),
        child: Center(
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteErrorState) {
                return Text("Что-то пошло не так :(");
              }
              if (state is FavoriteTeasSuccessfulFetchedState) {
                return CustomScrollView(slivers: [_SliverFavoriteTeasGrid(teas: state.teas)]);
              }
              return LoadingScreen();
            },
          ),
        ),
      ),
    );
  }
}

class _SliverFavoriteTeasGrid extends StatelessWidget {
  const _SliverFavoriteTeasGrid({super.key, required this.teas});
  final List<TeaModel> teas;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Center(child: TeaCardToAdd(tea: teas[index], onFavoriteChanged: null));
      }, childCount: teas.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
    );
  }
}
