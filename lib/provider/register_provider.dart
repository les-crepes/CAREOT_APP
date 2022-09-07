import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdg_app/api/firebase_connection.dart';
import 'package:pdg_app/widgets/loading_overlay.dart';

import '../model/user.dart';

/// This class manage the registration of a new user.
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
  final LoadingOverlayController _loadingController =
      LoadingOverlayController();

  DateTime _birthDay = DateTime.now();
  final FirebaseConnection connectionApi = FirebaseConnection();

  TextEditingController get firstnameController => _firstnameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get insuranceController => _insuranceController;
  LoadingOverlayController get loadingController => _loadingController;
  DateTime get birthDay => _birthDay;

  final _formPage1 = GlobalKey<FormState>();
  final _formPage2 = GlobalKey<FormState>();
  final _formPage3 = GlobalKey<FormState>();

  GlobalKey<FormState> get formPage1 => _formPage1;
  GlobalKey<FormState> get formPage2 => _formPage2;
  GlobalKey<FormState> get formPage3 => _formPage3;

  /// Returns an [User] object with the data from the form.
  User createUser() {
    return User(
      firstName: _firstnameController.text,
      lastName: _lastnameController.text,
      phoneNumber: _phoneController.text,
      avs: _insuranceController.text,
      birthDate: _birthDay,
      email: emailController.text,
    );
  }

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

  /// Checks if the password and the confirm password are the same
  bool verifyPassword() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  /// Checks if the email is not used by another user.
  Future<bool> checkEmailValidity() async {
    return !(await connectionApi.checkIfEmailInUse(_emailController.text));
  }
}
