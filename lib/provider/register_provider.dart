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
}
