import 'package:pdg_app/model/dietitian.dart';

abstract class IDietitian {
  void createDietitian(Dietitian dietitian);
  Future<Dietitian> readDietitian(String dietitianId);
  void updateDietitian(Dietitian dietitian);
  void deleteDietitian(String dietitianId);
}