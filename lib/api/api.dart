import 'package:pdg_app/model/dietitian.dart';

import '../model/client.dart';
import '../model/aftercare.dart';

abstract class Api {
  // Auth
  signIn();
  signOut();

  // Aftercare
  void createAftercare(Aftercare aftercare);
  Future<Aftercare> readAftercare(String aftercareId);
  void updateAftercare(Aftercare aftercare);
  void deleteAftercare(String aftercareId);

  // Client
  void createClient(Client client);
  Future<Client> readClient(String clientId);
  void updateClient(Client client);
  void deleteClient(String clientId);

  // Dietitian
  void createDietitian(Dietitian dietitian);
  Future<Dietitian> readDietitian(String dietitianId);
  void updateDietitian(Dietitian dietitian);
  void deleteDietitian(String dietitianId);

  // Document
  void createDocument();
  Future<dynamic> readDocument();
  void updateDocument();
  void deleteDocument(String documentId);

  // Meal
  void createMeal();
  Future<dynamic> readMeal();
  void updateMeal();
  void deleteMeal(String mealId);

  // Message
  void createMessage();
  Future<dynamic> readMessage();
  void updateMessage();
  void deleteMessage(String messageId);
}
