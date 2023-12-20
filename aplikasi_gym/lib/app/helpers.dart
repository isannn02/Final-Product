import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperApp {
  static String formatPhoneNumber(String phoneNumber) {
    // Menghilangkan semua karakter non-digit
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Menambahkan kode negara jika dimulai dengan '0'
    if (cleanedNumber.startsWith('0')) {
      cleanedNumber = '+62${cleanedNumber.substring(1)}';
    }

    // Menambahkan kode negara jika tidak dimulai dengan '+'
    if (!cleanedNumber.startsWith('+')) {
      cleanedNumber = '+$cleanedNumber';
    }

    return cleanedNumber;
  }

  static void sendWhatsApp(
      {required String phoneNumbers, required String nametrainer}) async {
    final String phoneNumber = formatPhoneNumber(phoneNumbers);

    String chromeURL = "googlechrome://navigate?url=";
    String message = "Halo, coach $nametrainer";
    String url =
        "https://api.whatsapp.com/send?phone=$phoneNumber&text=$message";

    String fullURL = chromeURL + Uri.encodeFull(url);
    await launchUrl(Uri.parse(fullURL));
  }

  static void urlLaunchers({required String url}) async {
    String chromeURL = "googlechrome://navigate?url=";

    String fullURL = chromeURL + Uri.encodeFull(url);
    await launchUrl(Uri.parse(fullURL));
  }

  void showShortToast(String msg, Color colorBg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: colorBg,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
