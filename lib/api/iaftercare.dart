import 'package:pdg_app/model/aftercare.dart';

/// Interface for the aftercare API
abstract class IAftercare {
  /// Add [aftercare] to the database
  void createAftercare(Aftercare aftercare);
  /// Returns the aftercare in the database with [aftercareId]
  Future<Aftercare> readAftercare(String aftercareId);
  /// Get the aftercares of the client [clientId]
  Future<List<Aftercare>> readAftercareOfClient(String clientId);
  /// Update the [aftercare] in the database
  void updateAftercare(Aftercare aftercare);
  /// Delete the aftercare with [aftercareId] from the database
  void deleteAftercare(String aftercareId);
}
