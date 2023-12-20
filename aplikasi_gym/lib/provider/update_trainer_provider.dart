import 'dart:io';

import 'package:aplikasi_body_goals/model/trainer_model.dart';
import 'package:flutter/material.dart';

import '../app/helpers.dart';
import '../services/all_services.dart';
import '../utils/finite_state.dart';

class UpdateTrainerProvider extends ChangeNotifier {
  final service = AllServices();
  MyState state = MyState.loading;

  final TextEditingController trainerNameControler = TextEditingController();
  final TextEditingController numberPhone = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String imageTrainerPath = '';
  File? imagefiles;
  Trainer? trainerData;

  void clear() {
    trainerNameControler.clear();
    numberPhone.clear();
    imageController.clear();
    imageTrainerPath = "";
    notifyListeners();
  }

  setinitial({required Trainer trainer}) {
    trainerData = trainer;
    trainerNameControler.text = trainer.name;
    numberPhone.text = trainer.phone;
    imageController.text = trainer.photo;
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
      debugPrint(imageTrainerPath);
      // debugPrint(trainerData!.id);
      debugPrint(trainerNameControler.text);
      debugPrint(numberPhone.text);

      final response = await service.updateTrainer(
          iamgeFilePath: imageTrainerPath,
          idTrainer: trainerData!.id,
          nameTrainer: trainerNameControler.text,
          phone: numberPhone.text);
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
