import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
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

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
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
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        showSnackBar(context, "Отказано в доступе");
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          // Title and choose type of tea dropdown
          _buildTitleAndType(context, pickImage),

          // Just SizedBox
          SizedBox(height: MediaQuery.of(context).size.height / 30),

          // Custom separator
          _buildSeparator(),

          // Description
          _buildDescriptionTextField(context),

          // Price and Year text fields
          _buildPriceAndYearFields(),

          // Here we build gathering place text field
          _buildGatheringPlaceField(),

          // Here we create button from core widget
          _buildDoneButton(),
        ],
      ),
    );
  }


  /// BUILD METHODS ///

  Container _buildSeparator() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black.withAlpha(200)),
      height: 4,
      width: double.maxFinite,
    );
  }

  SizedBox _buildDoneButton() {
    return SizedBox(
      width: double.maxFinite,
      child: StylizedButton(onPressed: () {}, text: "Добавить", backgroundColor: AppColors.applicationBaseColor),
    );
  }

  SizedBox _buildGatheringPlaceField() =>
      SizedBox(width: double.maxFinite, height: 100, child: StylizedTextField(lableText: "Место производства"));

  SizedBox _buildDescriptionTextField(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 8,
      child: StylizedTextField(lableText: "Описание"),
    );
  }

  Row _buildPriceAndYearFields() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            width: 50,
            height: 100,
            child: StylizedTextField(lableText: "Цена/Грамм", isNumberKeyboard: true),
          ),
        ),
        Expanded(child: SizedBox()),
        Expanded(
          flex: 3,
          child: SizedBox(
            width: 50,
            height: 100,
            child: StylizedTextField(lableText: "Год сбора", isNumberKeyboard: true),
          ),
        ),
      ],
    );
  }

  Row _buildTitleAndType(BuildContext context, Future<void> Function() pickImage) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                child: StylizedTextField(lableText: "Название"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  underline: ColoredBox(color: AppColors.applicationBaseColor, child: SizedBox(height: 2, width: 100)),
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
                      : Positioned(child: Image.asset(pathToTeaImage, fit: BoxFit.cover)),
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
                              ).textTheme.bodySmall!.copyWith(fontSize: 12, color: AppColors.applicationBaseColor),
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
}
