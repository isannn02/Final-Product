import 'dart:io';

import 'package:aplikasi_body_goals/model/nutrition_model.dart';
import 'package:flutter/material.dart';

import '../app/helpers.dart';
import '../services/all_services.dart';
import '../utils/finite_state.dart';

class UpdateNutritionProvider extends ChangeNotifier {
  final service = AllServices();
  MyState state = MyState.loading;

  final TextEditingController nutrionNameControler = TextEditingController();
  final TextEditingController linkNutrions = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  String imageNutritionPath = '';
  File? imagefiles;

  Nutrition? nutrionSelected;

  void clear() {
    nutrionNameControler.clear();
    linkNutrions.clear();
    imageController.clear();
    imageNutritionPath = "";
    notifyListeners();
  }

  setinitial({required Nutrition nutrion}) {
    nutrionSelected = nutrion;
    nutrionNameControler.text = nutrion.name;
    linkNutrions.text = nutrion.link;
    imageController.text = nutrion.photo;

    notifyListeners();
  }

  Future<bool> updateNutrion(
      //   {
      ) async {
    if (state == MyState.loaded || state == MyState.failed) {
      state = MyState.loading;
      notifyListeners();
    }
    try {
      debugPrint(imageNutritionPath);
      debugPrint(linkNutrions.text);
      debugPrint(nutrionSelected!.id);
      debugPrint(nutrionNameControler.text);

      final response = await service.updateNutrition(
          iamgeFilePath: imageNutritionPath,
          link: linkNutrions.text,
          idNutrion: nutrionSelected!.id,
          name: nutrionNameControler.text);
      // print('$response');
      state = MyState.loaded;
      notifyListeners();
      clear();
      HelperApp().showShortToast(response, Colors.green);
      return true;
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
      HelperApp().showShortToast(e.toString(), Colors.red.shade400);
      return false;
    }
  }
}
