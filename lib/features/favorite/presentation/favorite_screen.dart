import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 12,
            backgroundColor: Colors.black,
            flexibleSpace: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 36, right: 16),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app_rounded, size: 27)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BaseGradientContainer(height: MediaQuery.of(context).size.height / 25, stops: [0.8, 0.9, 1]),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteErrorState) {
                return SliverToBoxAdapter(child: Center(child: Text("Что-то пошло не так :(")));
              }
              if (state is FavoriteTeasSuccessfulFetchedState) {
                return _SliverFavoriteTeasGrid(teas: state.teas);
              }
              return SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.of(context).size.height / 1.4, child: LoadingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SliverFavoriteTeasGrid extends StatelessWidget {
  const _SliverFavoriteTeasGrid({required this.teas});
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
