import 'package:flutter/material.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';

class CreateNewTeaScreen extends StatefulWidget {
  const CreateNewTeaScreen({super.key});

  @override
  State<CreateNewTeaScreen> createState() => _CreateNewTeaScreenState();
}

class _CreateNewTeaScreenState extends State<CreateNewTeaScreen> {
  String? currentTeaType;
  String pathToTeaImage = "assets/images/without_image.png";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      width: 100,
                      child: StylizedTextField(lableText: "Название"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: DropdownButton<String>(
                        underline: ColoredBox(
                          color: AppColors.applicationBaseColor,
                          child: SizedBox(height: 2, width: 100),
                        ),
                        value: currentTeaType,
                        style: Theme.of(context).textTheme.bodySmall,
                        focusColor: Colors.amber,
                        hint: Text("Тип чая", style: Theme.of(context).textTheme.bodySmall),
                        items:
                            teaTypesList.sublist(1).map((tea) {
                              return DropdownMenuItem<String>(value: tea, child: Text(tea));
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            currentTeaType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ), // title and type fields
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Positioned(child: Image.asset(pathToTeaImage, fit: BoxFit.cover)),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 11.5,
                      right: MediaQuery.of(context).size.width / 16,
                      top: MediaQuery.of(context).size.height / 8.5,
                      child: Text(
                        "Добавить",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(fontSize: 12, color: AppColors.applicationBaseColor),
                      ),
                    ),
                  ],
                ),
              ), // image field
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black.withAlpha(200)),
            height: 4,
            width: double.maxFinite,
          ),
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 8,
            child: StylizedTextField(lableText: "Описание"),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(width: 50, height: 100, child: StylizedTextField(lableText: "Цена/Грамм")),
              ),
              Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: SizedBox(width: 50, height: 100, child: StylizedTextField(lableText: "Год сбора")),
              ),
            ],
          ), // price and year
          SizedBox(width: double.maxFinite, height: 100, child: StylizedTextField(lableText: "Место производства")),
          SizedBox(
            width: double.maxFinite,
            child: StylizedButton(onPressed: () {}, text: "Добавить", backgroundColor: AppColors.applicationBaseColor),
          ),
        ],
      ),
    );
  }
}
