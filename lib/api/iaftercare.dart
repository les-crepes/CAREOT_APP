import 'package:pdg_app/model/aftercare.dart';

abstract class IAftercare {
  void createAftercare(Aftercare aftercare);
  Future<Aftercare> readAftercare(String aftercareId);
  Future<List<Aftercare>> readAftercareOfClient(String clientId);
  void updateAftercare(Aftercare aftercare);
  void deleteAftercare(String aftercareId);
}
