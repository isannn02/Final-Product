import 'dart:io';
import 'package:aplikasi_body_goals/app/helpers.dart';
import 'package:aplikasi_body_goals/provider/update_article_provider.dart';
import 'package:aplikasi_body_goals/provider/update_nutrition_provider.dart';
import 'package:aplikasi_body_goals/provider/update_trainer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum ScreenType {
  editArticle,
  editTrainer,
  editNutrion,
}

class AdminTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isImage;
  final TextEditingController controller;
  final String validatorText;
  final ScreenType type;

  const AdminTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.isImage,
    required this.controller,
    required this.validatorText,
    required this.type,
  });

  @override
  State<AdminTextField> createState() => _AdminTextFieldState();
}

class _AdminTextFieldState extends State<AdminTextField> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        // color: Color.fromRGBO(217, 217, 217, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 2),
            child: widget.isImage
                ? InkWell(
                    onTap: () {
                      switch (widget.type) {
                        case ScreenType.editArticle:
                          {
                            pickImageArticle();
                          }
                          break;
                        case ScreenType.editNutrion:
                          {
                            pickImageNutrition();
                          }
                          break;
                        case ScreenType.editTrainer:
                          {
                            pickImageTrainer();
                          }
                          break;
                        default:
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(15))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              image != null ? image!.path : widget.hint,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : TextFormField(
                    controller: widget.controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.validatorText;
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: const TextStyle(color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight:
                                  Radius.circular(20)) // Set the radius here
                          ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future pickImageArticle() async {
    final editArticleProv =
        Provider.of<UpdateArticleProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
      if (image == null) return;
      final imageTemp = File(image.path);
      editArticleProv.imageArticlePath = image.path;
      setState(() => this.image = imageTemp);
      // isEmpty();
    } on PlatformException catch (e) {
      HelperApp().showShortToast("Failed to pick image: $e", Colors.red);
    }
  }

  Future pickImageNutrition() async {
    final editNutritionProv =
        Provider.of<UpdateNutritionProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
      if (image == null) return;
      final imageTemp = File(image.path);
      editNutritionProv.imageNutritionPath = image.path;
      setState(() => this.image = imageTemp);
      // isEmpty();
    } on PlatformException catch (e) {
      HelperApp().showShortToast("Failed to pick image: $e", Colors.red);
    }
  }

  Future pickImageTrainer() async {
    final editTrainersProv =
        Provider.of<UpdateTrainerProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
      if (image == null) return;
      final imageTemp = File(image.path);
      editTrainersProv.imageTrainerPath = image.path;
      setState(() => this.image = imageTemp);
      // isEmpty();
    } on PlatformException catch (e) {
      HelperApp().showShortToast("Failed to pick image: $e", Colors.red);
    }
  }
}
