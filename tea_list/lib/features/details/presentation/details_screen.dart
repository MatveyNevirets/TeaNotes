import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/container_with_image.dart';
import 'package:tea_list/core/widgets/custom_bottom_bar.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/shared/data/models/tea_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.tea});

  final TeaModel tea;

  @override
  Widget build(BuildContext context) {
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
  }
}
