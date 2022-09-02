import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  XFile? _profilePicture;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _insuranceController = TextEditingController();

  DateTime _birthDay = DateTime.now();

  TextEditingController get firstnameController => _firstnameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get insuranceController => _insuranceController;
  DateTime get birthDay => _birthDay;

  final _formPage1 = GlobalKey<FormState>();
  final _formPage2 = GlobalKey<FormState>();
  final _formPage3 = GlobalKey<FormState>();

  GlobalKey<FormState> get formPage1 => _formPage1;
  GlobalKey<FormState> get formPage2 => _formPage2;
  GlobalKey<FormState> get formPage3 => _formPage3;

  set birthday(DateTime birthday) {
    _birthDay = birthday;
    notifyListeners();
  }

  XFile? get profilePicture {
    return _profilePicture;
  }

  set profilePicture(XFile? profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  bool verifyPassword() {
    return _passwordController.text == _confirmPasswordController.text;
  }
}
