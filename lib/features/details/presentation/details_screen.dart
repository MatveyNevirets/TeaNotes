// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/are_you_sure_dialog.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/container_with_image.dart';
import 'package:tea_list/core/widgets/custom_bottom_bar.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/features/details/presentation/bloc/details_bloc.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.homeContext, required this.tea});

  final BuildContext homeContext;
  final TeaModel tea;

  void deleteTea(BuildContext context) {
    context.read<DetailsBloc>().add(SendDialogDetailsDeleteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsState>(
      listener: (context, state) {
        if (state is SuccessfulDeleteState) {
          Navigator.of(context).pop();
          goTo(context, "/main_page");
          homeContext.read<HomeBloc>().add(FetchDataEvent(0));
          showSnackBar(context, state.message);
        }
        if (state is ErrorDeleteState) {
          showSnackBar(context, state.message);
        }
        if (state is AreYouSureDeleteDetailsState) {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AreYouSureDialog(
                onNot: () => Navigator.of(dialogContext).pop(),
                onYes: () {
                  context.read<DetailsBloc>().add(ISureDeleteEvent(tea: tea));
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: CustomBottomBar(
            verticalPadding: 16,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.amber, blurRadius: 1, spreadRadius: 1)],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: StylizedButton(
                  onPressed: () {},
                  text: "Начать церемонию",
                  fontSize: 16,
                  backgroundColor: AppColors.selectedItemColor,
                  buttonSize: Size(MediaQuery.of(context).size.width - 80, MediaQuery.of(context).size.width / 7),
                ),
              ),
            ],
          ),
          body: Center(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 320,
                  backgroundColor: Colors.transparent,
                  iconTheme: Theme.of(context).iconTheme,
                  actionsPadding: EdgeInsets.symmetric(horizontal: 8),
                  actions: [IconButton(onPressed: () => deleteTea(context), icon: Icon(Icons.delete))],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      children: [
                        Positioned(top: 0, right: 0, left: 0, child: BaseGradientContainer()),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 8,
                          left: MediaQuery.of(context).size.width / 10,
                          right: MediaQuery.of(context).size.width / 10,
                          child: ContainerWithImage(imagePath: tea.imagePath),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                    child: Text(tea.title, style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).size.height / 200)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                    child: Text(tea.type, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).size.height / 30)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                    color: Colors.black.withAlpha(40),
                    height: 2,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).size.height / 30)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                    child: Text("Описание", style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).size.height / 30)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                    child: Text(
                      "${tea.description}\n\nЦена чая за грамм\n${tea.pricePerGram} рублей\n\nРекомендуем заваривать данный чай при температуре ${tea.brewingTemperature}. В среднем он способен выдержать ${tea.countOfSpills} проливов\n\nГод сбора: ${tea.gatheringYear}\n\nМесто производства: ${tea.gatheringPlace}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).size.height / 6)),
              ],
            ),
          ),
        );
      },
    );
  }
}
