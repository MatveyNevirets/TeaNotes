import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teaTypesController = PageController(viewportFraction: 0.5);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromARGB(0, 0, 0, 0),
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(255, 0, 0, 0),
                          ],
                          stops: [0.0, 0.02, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 6,
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(220, 0, 0, 0),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(220, 255, 255, 255),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset("assets/images/tea_background.jpg", fit: BoxFit.cover),
                      ),
                    ),
                  ),
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
              } else if (state is HomeInitial) {
                context.read<HomeBloc>().add(FetchDataEvent(0));
              } else if (state is ErrorState) {
                return SliverToBoxAdapter(child: Text("Fucking error: ${state.error}"));
              }
              return SliverToBoxAdapter(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
