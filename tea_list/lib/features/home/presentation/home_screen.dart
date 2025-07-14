import 'package:flutter/material.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/home/widgets/tea_card_to_add.dart';
import 'package:tea_list/shared/domain/models/tea_model.dart';

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
                    child: TeaTypesTab(onTeaTypeChanged: () => print("changed")),
                  ),
                ],
              ),
            ),
          ),

          SliverGrid.builder(
            itemCount: teaList.length,
            itemBuilder: (context, index) {
              return Center(child: TeaCardToAdd(tea: teaList[index]));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}

List<Tea> teaList = [
  Tea(
    title: "Золотой\nБык",
    description: "Золотой\nБык от синь вэнь",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 12,
    age: 2,
    type: "Шен Пуэр",
    brewingTemperature: 95,
    countOfSpills: 8,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Золотой\nБык",
    description: "Золотой\nБык от синь вэнь",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 12,
    age: 2,
    type: "Шен Пуэр",
    brewingTemperature: 95,
    countOfSpills: 8,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Золотой\nБык",
    description: "Золотой\nБык от синь вэнь",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 12,
    age: 2,
    type: "Шен Пуэр",
    brewingTemperature: 95,
    countOfSpills: 8,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Золотой\nБык",
    description: "Золотой\nБык от синь вэнь",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 12,
    age: 2,
    type: "Шен Пуэр",
    brewingTemperature: 95,
    countOfSpills: 8,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),

  ///
  Tea(
    title: "Да Цзинь Чжень",
    description: "Красный из юньнани",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 10,
    age: 4,
    type: "Красный",
    brewingTemperature: 95,
    countOfSpills: 6,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Да Цзинь Чжень",
    description: "Красный из юньнани",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 10,
    age: 4,
    type: "Красный",
    brewingTemperature: 95,
    countOfSpills: 6,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Да Цзинь Чжень",
    description: "Красный из юньнани",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 10,
    age: 4,
    type: "Красный",
    brewingTemperature: 95,
    countOfSpills: 6,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
  Tea(
    title: "Да Цзинь Чжень",
    description: "Красный из юньнани",
    imagePath: "assets/images/tea_background.jpg",
    pricePerGram: 10,
    age: 4,
    type: "Красный",
    brewingTemperature: 95,
    countOfSpills: 6,
    gatheringYear: 2023,
    gatheringPlace: "Юньнань",
  ),
];
