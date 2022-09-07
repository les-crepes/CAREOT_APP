import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/model/aftercare.dart';

/// This class is used to provide the aftercare data to the widgets
class AftercareProvider extends ChangeNotifier {
  final FirebaseAftercare _firebaseAftercare;
  Aftercare? _aftercare;
  bool _loading;

  AftercareProvider({required clientUid})
      : _firebaseAftercare = FirebaseAftercare(FirebaseFirestore.instance),
        _loading = false {
    fetchAfterCare(clientUid);
  }

  /// Returns the current aftercare
  Aftercare? get aftercare => _aftercare;

  /// Returns the current loading state
  bool get loading => _loading;

  /// Fetches the aftercare data from the database.
  ///
  /// This method is called in the constructor.
  /// It sets the [loading] state to true until the data is fetched.
  Future<void> fetchAfterCare(String clientUid) async {
    _loading = true;
    List<Aftercare> aftercares =
        await _firebaseAftercare.readAftercareOfClient(clientUid);
    if (aftercares.isNotEmpty) {
      _aftercare = aftercares.first;
    }

    _loading = false;
    notifyListeners();
  }

  /// Updates the aftercare data in the database.
  void updateAftercare(Aftercare aftercare) {
    _firebaseAftercare.updateAftercare(aftercare);
    _aftercare = aftercare;
    notifyListeners();
  }

  /// Creates a new aftercare data in the database.
  void createAftercare(Aftercare aftercare) {
    _firebaseAftercare.createAftercare(aftercare);
    _aftercare = aftercare;
    notifyListeners();
  }
}
