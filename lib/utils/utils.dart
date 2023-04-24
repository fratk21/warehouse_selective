import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warehouse_selective/screens/onboarding/screen_three.dart';
import 'package:warehouse_selective/screens/onboarding/screen_two.dart';
import 'package:flutter/material.dart';
import '../screens/onboarding/screen_one.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<OnboardingScreenOne>(() => OnboardingScreenOne());
    register<OnboardingScreenTwo>(() => OnboardingScreenTwo());
    register<OnboardingScreenThree>(() => OnboardingScreenThree());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  try {
    XFile? _file = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (_file != null) {
      print(_file.readAsBytes());
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> showsnackbar(
    BuildContext context, String text, AnimatedSnackBarType type) {
  return AnimatedSnackBar.material(
    text,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    snackBarStrategy: RemoveSnackBarStrategy(),
  ).show(context);
}
