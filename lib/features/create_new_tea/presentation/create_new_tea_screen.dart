import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_overlay_snackbar.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/features/create_new_tea/presentation/bloc/create_tea_bloc.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';

class CreateNewTeaScreen extends StatefulWidget {
  CreateNewTeaScreen({super.key, required this.previousContext});
  BuildContext previousContext;

  @override
  State<CreateNewTeaScreen> createState() => _CreateNewTeaScreenState();
}

class _CreateNewTeaScreenState extends State<CreateNewTeaScreen> {
  String? currentTeaType;
  String pathToTeaImage = "assets/images/without_image.png";

  File? _imageFile;

  final titleController = TextEditingController(),
      descriptionController = TextEditingController(),
      priceController = TextEditingController(),
      yearController = TextEditingController(),
      placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void createTea(
      String title,
      String description,
      String teaType,
      String imagePath,
      String gatheringPlace,
      int countOfPills,
      String gatheringYear,
      String pricePerGram,
    ) {
      if (title.isEmpty ||
          description.isEmpty ||
          teaType.isEmpty ||
          imagePath.isEmpty ||
          gatheringPlace.isEmpty ||
          gatheringYear.isEmpty ||
          pricePerGram.isEmpty) {
        showOverlaySnackBar(context, "Корректно заполните поля!");
      } else {
        final gathYear = int.parse(gatheringYear);
        final prPerGram = int.parse(pricePerGram);

        if (gathYear < 1300 || gathYear > DateTime.now().year || prPerGram < 1 || prPerGram > 90000) {
          showOverlaySnackBar(context, "Заполните все поля или корректно введите данные!");
        } else {
          Navigator.of(context).pop();

          context.read<CreateTeaBloc>().add(
            AddTeaEvent(
              tea: TeaModel(
                title: title,
                description: description,
                imagePath: imagePath,
                pricePerGram: prPerGram,
                age: 0,
                type: currentTeaType!,
                brewingTemperature: "???",
                countOfSpills: 8,
                gatheringYear: gathYear,
                gatheringPlace: gatheringPlace,
              ),
            ),
          );
          log(
            "Added: $title $description $teaType $imagePath $gatheringPlace $countOfPills $gatheringYear $pricePerGram",
          );
          widget.previousContext.read<HomeBloc>().add(FetchDataEvent(0));
          showSnackBar(context, "Чай $title успешно добавлен!");
        }
      }
    }

    /// Fetch Permissions method. Calls requests to the phone storage
    /// And returns true or false when user choose themself desire
    Future<bool> fetchPermissions() async {
      final PermissionStatus status;
      int sdkInt = 0;

      try {
        final info = await DeviceInfoPlugin().androidInfo;
        sdkInt = info.version.sdkInt;
      } catch (e) {
        sdkInt = 0;
      }

      if (sdkInt >= 33) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }

      return status.isGranted ? true : false;
    }

    /// Method of pick image
    /// In first, we create ImagePicker object
    /// Then we fetch permission result
    /// And try to pick image
    Future<void> pickImage() async {
      final picker = ImagePicker();
      final permissionsResult = await fetchPermissions();

      if (permissionsResult) {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          setState(() {
            _imageFile = File(pickedFile.path);
          });
        }
      } else {
        showOverlaySnackBar(context, "Отказано в доступе");
      }
    }

    /// BUILD METHODS ///

    Container buildSeparator() {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black.withAlpha(200)),
        height: 4,
        width: double.maxFinite,
      );
    }

    SizedBox buildDoneButton() {
      return SizedBox(
        width: double.maxFinite,
        child: StylizedButton(
          onPressed:
              () => createTea(
                titleController.text,
                descriptionController.text,
                currentTeaType ?? "",
                _imageFile?.path ?? "assets/images/tea_background.jpg",
                placeController.text,
                8,
                yearController.text,
                priceController.text,
              ),
          text: "Добавить",
          backgroundColor: AppColors.applicationBaseColor,
        ),
      );
    }

    SizedBox buildGatheringPlaceField() => SizedBox(
      width: double.maxFinite,
      height: 100,
      child: StylizedTextField(lableText: "Место производства", controller: placeController),
    );

    SizedBox buildDescriptionTextField(BuildContext context) {
      return SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 8,
        child: StylizedTextField(lableText: "Описание", controller: descriptionController),
      );
    }

    Row buildPriceAndYearFields() {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 50,
              height: 100,
              child: StylizedTextField(lableText: "Цена/Гр", controller: priceController, isNumberKeyboard: true),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 50,
              height: 100,
              child: StylizedTextField(lableText: "Год сбора", controller: yearController, isNumberKeyboard: true),
            ),
          ),
        ],
      );
    }

    Row buildTitleAndType(BuildContext context, Future<void> Function() pickImage) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width,
                  child: StylizedTextField(lableText: "Название", controller: titleController),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    dropdownColor: AppColors.applicationBaseColor,
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
            child: GestureDetector(
              onTap: pickImage,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    _imageFile != null
                        ? Positioned(
                          left: MediaQuery.of(context).size.width / 100,
                          right: MediaQuery.of(context).size.width / 100,
                          top: MediaQuery.of(context).size.height / 100,
                          bottom: MediaQuery.of(context).size.height / 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(_imageFile!, fit: BoxFit.cover),
                          ),
                        )
                        : Positioned(child: Image.asset(pathToTeaImage, fit: BoxFit.cover, color: Colors.black)),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 11.5,
                      right: MediaQuery.of(context).size.width / 16,
                      top: MediaQuery.of(context).size.height / 8.5,
                      child:
                          _imageFile == null
                              ? Text(
                                "Добавить",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.black),
                              )
                              : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ), // image field
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: BlocBuilder<CreateTeaBloc, CreateTeaState>(
        builder: (context, state) {
          if (state is CreateTeaInitial) {
            return Column(
              children: [
                // Title and choose type of tea dropdown
                buildTitleAndType(context, pickImage),

                // Just SizedBox
                SizedBox(height: MediaQuery.of(context).size.height / 30),

                // Custom separator
                buildSeparator(),

                // Description
                buildDescriptionTextField(context),

                // Price and Year text fields
                buildPriceAndYearFields(),

                // Here we build gathering place text field
                buildGatheringPlaceField(),

                // Here we create button from core widget
                buildDoneButton(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
