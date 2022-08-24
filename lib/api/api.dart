import 'package:pdg_app/model/document.dart';
import 'package:pdg_app/model/client.dart';
import 'package:pdg_app/model/aftercare.dart';

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

  // Document
  void createDocument(Document document);
  Future<Document> readDocument(String documentId);
  void updateDocument(Document document);
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

  // Dietician
  void createDietician();
  Future<dynamic> readDietician();
  void updateDietician();
  void deleteDietician(String dieticianId);
}
