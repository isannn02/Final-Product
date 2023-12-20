import 'dart:io';

import 'package:aplikasi_body_goals/app/helpers.dart';

import 'package:flutter/material.dart';

import '../model/article_model.dart';
import '../services/all_services.dart';
import '../utils/finite_state.dart';

class UpdateArticleProvider extends ChangeNotifier {
  final service = AllServices();
  MyState state = MyState.loading;

  PageController pageControllerArticle = PageController();
  final TextEditingController headingControler = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  List<Article> articles = [];
  Article? seelctedArticle;
  String imageArticlePath = '';
  File? imagefiles;

  void setArticle(List<Article> newArticleList) {
    articles = newArticleList;
    notifyListeners();
  }

  Article getSelectedArticle() {
    if (pageControllerArticle.page == null) {
      seelctedArticle = articles[0];
      return articles[0];
    }
    seelctedArticle = articles[pageControllerArticle.page!.toInt()];
    return articles[pageControllerArticle.page!.toInt()];
  }

  void initial() async {
    var artikel = getSelectedArticle();
    headingControler.text = artikel.title;
    link.text = artikel.url;
    imageController.text = artikel.photo;
  }

  void nextPages() {
    pageControllerArticle.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPages() {
    pageControllerArticle.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void clear() {
    headingControler.clear();
    link.clear();
    imageController.clear();
    imageArticlePath = "";
    notifyListeners();
  }

  Future<bool> updateArticles(
      //   {
      ) async {
    if (state == MyState.loaded || state == MyState.failed) {
      state = MyState.loading;
      notifyListeners();
    }
    try {
      debugPrint(imageArticlePath);
      debugPrint(link.text);
      debugPrint("${seelctedArticle?.id}");
      debugPrint(headingControler.text);

      final response = await service.updateArticle(
          filePath: imageArticlePath,
          detail: link.text,
          idArticle: "${seelctedArticle?.id}",
          title: headingControler.text);
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
