import 'package:pdg_app/model/dietitian.dart';

abstract class IDietitian {
  void createDietitian(Dietitian dietitian);
  Future<Dietitian> readDietitian(String dietitianId);
  Future<Dietitian> readDietitianOfClient(String clientId);
  void updateDietitian(Dietitian dietitian);
  void deleteDietitian(String dietitianId);

}