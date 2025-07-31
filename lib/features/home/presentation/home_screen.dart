import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/container_with_image.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/create_new_tea/presentation/bloc/create_tea_bloc.dart';
import 'package:tea_list/features/create_new_tea/presentation/create_new_tea_screen.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/features/home/data/repository/tea_list_repository_impl.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addNewTea() {
      final datasource = GetIt.I<DataSource>();
      showDialog(
        context: context,
        builder: (dialogContext) {
          return BlocProvider(
            create: (BuildContext dialogContext) => CreateTeaBloc(teaListRepository: TeaListRepositoryImpl(datasource)),
            child: AlertDialog.adaptive(
              backgroundColor: AppColors.applicationBackroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 10, color: Colors.black),
                borderRadius: BorderRadiusGeometry.circular(32),
              ),
              insetPadding: const EdgeInsets.all(16),
              content: CreateNewTeaScreen(previousContext: context),
            ),
          );
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
                    onChanged: () => searchTea(teaName: searchController.text),
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
            expandedHeight: MediaQuery.of(context).size.height / 3,
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
                      child: ContainerWithImage(imagePath: "assets/images/tea_background.jpg"),
                    ),
                  ),

                  // This is a tea tabs what helps choose types of tea and then filter base tea list for the user
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3.5,
                    left: 10,
                    right: 10,
                    height: 50,
                    child: TeaTypesTab(
                      onTeaTypeChanged: (index) => context.read<HomeBloc>().add(FetchDataEvent(index)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HasDataState) {
                return SliverTeasGrid(state: state);
              } else if (state is HomeInitial) {
                searchTea();
              } else if (state is ErrorState) {
                searchTea();
                return SliverToBoxAdapter(child: Text("BLoC error in presentation layer: ${state.error}"));
              }
              return SliverToBoxAdapter(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

// Moved to clean up code
class SliverTeasGrid extends StatelessWidget {
  const SliverTeasGrid({super.key, required this.state});
  final HasDataState state;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Center(child: TeaCardToAdd(tea: state.teaList[index]));
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
