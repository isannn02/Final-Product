import 'package:aplikasi_body_goals/AppState.dart';
import 'package:aplikasi_body_goals/components/AdminTextField.dart';
import 'package:aplikasi_body_goals/components/BackButtonTopComponent.dart';
import 'package:aplikasi_body_goals/pages/bulk/BulkNutritionPage.dart';
import 'package:aplikasi_body_goals/pages/cut/CutNutritionPage.dart';
import 'package:aplikasi_body_goals/provider/update_nutrition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNutritionPage extends StatefulWidget {
  final String page;
  const EditNutritionPage({Key? key, required this.page}) : super(key: key);

  @override
  _EditNutritionPageState createState() => _EditNutritionPageState();
}

class _EditNutritionPageState extends State<EditNutritionPage> {
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _linkController = TextEditingController();
  // File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final nutritionProv = Provider.of<UpdateNutritionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.only(top: 36),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/bg_gym_2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: BackButtonTopComponent(
                  route: appState.workout == 'bulk'
                      ? '/bulk/nutrition'
                      : '/cut/nutrition'),
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 4, top: 4),
                      margin: const EdgeInsets.only(top: 14, bottom: 14),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(25, 176, 0, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: const Text(
                        'Nutrition: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    const Text(
                      'Suplemen ',
                      style: TextStyle(
                          color: Color.fromRGBO(25, 176, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    AdminTextField(
                      label: "Name",
                      hint: "",
                      isImage: false,
                      controller: nutritionProv.nutrionNameControler,
                      validatorText: "Please enter nutrition name",
                      type: ScreenType.editNutrion,
                    ),
                    AdminTextField(
                      label: "Link",
                      hint: "",
                      isImage: false,
                      controller: nutritionProv.linkNutrions,
                      validatorText: "Please enter your link",
                      type: ScreenType.editNutrion,
                    ),
                    AdminTextField(
                      label: "Image",
                      hint: "",
                      isImage: true,
                      controller: nutritionProv.imageController,
                      validatorText: "Please enter your image",
                      type: ScreenType.editNutrion,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              context
                                  .read<UpdateNutritionProvider>()
                                  .updateNutrion()
                                  .then((value) {
                                if (value == true) {
                                  if (widget.page == 'cut') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CutNutritionPage(),
                                        ));
                                  } else if (widget.page == 'bulk') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BulkNutritionPage(),
                                        ));
                                  }
                                }
                              })
                            }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(25, 176, 0, 1),
                          // Background color of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the radius here
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black, // Text color
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
