import 'package:pdg_app/model/aftercare.dart';

abstract class IAftercare {
  void createAftercare(Aftercare aftercare);
  Future<Aftercare> readAftercare(String aftercareId);
  void updateAftercare(Aftercare aftercare);
  void deleteAftercare(String aftercareId);
}
