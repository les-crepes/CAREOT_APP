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
    //TODO décommenter
    List<Aftercare> aftercares =
        await _firebaseAftercare.readAftercareOfClient(clientUid);
    if (aftercares != null) _aftercare = aftercares.first;
    // await Future.delayed(const Duration(seconds: 1));
    // _aftercare = Aftercare(
    //   clientId: "",
    //   bmi: 20,
    //   weight: 60,
    //   comments: "Super",
    //   diagnostic: "Gnagna",
    //   foodObjectives: "iuheui",
    //   motivations: "jkhk",
    //   startDate: DateTime(2022, 03, 02),
    // );

    _loading = false;
    notifyListeners();
  }

  Future<void> updateAftercare(Aftercare aftercare) async {
    _firebaseAftercare.updateAftercare(aftercare);
    _aftercare = aftercare;
    notifyListeners();
  }
}
