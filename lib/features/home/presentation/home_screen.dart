import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/container_with_image.dart';
import 'package:tea_list/core/widgets/stylized_loading_indicator.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/presentation/create_tea_dialog_page.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addNewTea() {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return CreateTeaDialogPage();
        },
      );
    }

    void searchTea({String? teaName}) {
      context.read<HomeBloc>().add(FetchDataEvent(0, searchByName: teaName));
    }

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: FloatingActionButton(
          onPressed: () => addNewTea(),
          backgroundColor: AppColors.applicationBaseColor,
          foregroundColor: Colors.white,

          child: Icon(Icons.assignment_add, size: 24),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 5,
            toolbarHeight: 5,
            backgroundColor: Colors.black,
            flexibleSpace: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 16),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app_rounded, size: 27)),
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            backgroundColor: Colors.black.withAlpha(250),
            expandedHeight: MediaQuery.of(context).size.height / 8,
            toolbarHeight: MediaQuery.of(context).size.height / 10,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  child: StylizedTextField(
                    onChanged: (value) => searchTea(teaName: searchController.text),
                    lableText: "Поиск",
                    textColor: Colors.white,
                    controller: searchController,
                    isOutline: true,
                    size: Size(double.infinity, 100),
                  ),
                ),
              ),
            ),
          ),

          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            pinned: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // This is a background gradiend that fills 2/3 part of the screen.
                  Positioned(top: 0, right: 0, left: 0, child: BaseGradientContainer(height: 100)),

                  // Container with image in stack
                  Positioned(
                    top: MediaQuery.of(context).size.height / 20,
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10,
                    child: GestureDetector(
                      onTap: () => goTo(context, "/main_page/tea_posts"),
                      child: SizedBox(child: ContainerWithImage(imagePath: "assets/images/tea_background.png")),
                    ),
                  ),

                  // This is a tea tabs what helps choose types of tea and then filter base tea list for the user
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3,
                    left: 10,
                    right: 10,
                    height: 50,
                    child: TeaTabWidget(onTabChanged: (index) => context.read<HomeBloc>().add(FetchDataEvent(index))),
                  ),
                ],
              ),
            ),
          ),

          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HasDataState) {
                return _SliverTeasGrid(state: state);
              } else if (state is HomeInitial) {
                searchTea();
              } else if (state is ErrorState) {
                log(state.error);
                return SliverToBoxAdapter(child: Center(child: Text("Что-то пошло не так :(")));
              }
              return SliverToBoxAdapter(child: StylizedLoadingIndicator());
            },
          ),
        ],
      ),
    );
  }
}

class _SliverTeasGrid extends StatelessWidget {
  const _SliverTeasGrid({required this.state});
  final HasDataState state;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Center(
          child: TeaCardToAdd(
            tea: state.teaList[index],
            onFavoriteChanged:
                (bool isFavorite) => context.read<HomeBloc>().add(OnFavoriteChangedEvent(isFavorite, index)),
          ),
        );
      }, childCount: state.teaList.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
    );
  }
}
