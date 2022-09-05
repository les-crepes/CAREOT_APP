import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/model/aftercare.dart';

class AftercareProvider extends ChangeNotifier {
  // ignore: unused_field
  final FirebaseAftercare _firebaseAftercare;
  Aftercare? _aftercare;
  bool _loading;

  AftercareProvider({required clientUid})
      : _firebaseAftercare = FirebaseAftercare(FirebaseFirestore.instance),
        _loading = false {
    fetchAfterCare(clientUid);
  }

  Aftercare? get aftercare => _aftercare;

  bool get loading => _loading;

  void fetchAfterCare(String clientUid) async {
    _loading = true;
    List<Aftercare> aftercares =
        await _firebaseAftercare.readAftercareOfClient(clientUid);
    if (aftercares.isNotEmpty) {
      _aftercare = aftercares.first;
    }

    _loading = false;
    notifyListeners();
  }

  void updateAftercare(Aftercare aftercare) {
    _firebaseAftercare.updateAftercare(aftercare);
    _aftercare = aftercare;
    notifyListeners();
  }

  void createAftercare(Aftercare aftercare) {
    _firebaseAftercare.createAftercare(aftercare);
    _aftercare = aftercare;
    notifyListeners();
  }
}
