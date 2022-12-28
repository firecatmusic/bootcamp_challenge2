import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var selectedImagePath = ''.obs;

  void getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImagePath.value = pickedImage.path;
    } else {
      Get.snackbar("Error", "No Image Selected", colorText: Colors.white, backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
