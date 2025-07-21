import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/container_with_image.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/create_new_tea/presentation/create_new_tea_screen.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void addNewTea() {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog.adaptive(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 10, color: Colors.black),
                borderRadius: BorderRadiusGeometry.circular(32),
              ),
              insetPadding: const EdgeInsets.all(16),
              content: CreateNewTeaScreen(),
            ),
      );
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
            expandedHeight: MediaQuery.of(context).size.height / 2,
            pinned: true,
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // This is a background gradiend that fills 2/3 part of the screen.
                  Positioned(top: 0, right: 0, left: 0, child: BaseGradientContainer()),

                  // Container with image in stack
                  Positioned(
                    top: MediaQuery.of(context).size.height / 6,
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10,
                    child: ContainerWithImage(imagePath: "assets/images/tea_background.jpg"),
                  ),

                  // This is a tea tabs what helps choose types of tea and then filter base tea list for the user
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
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
                context.read<HomeBloc>().add(FetchDataEvent(0));
              } else if (state is ErrorState) {
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
