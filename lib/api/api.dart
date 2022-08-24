import '../model/client.dart';

abstract class Api {
  // Auth
  signIn();
  signOut();

  // Aftercare
  void createAftercare();
  Future<dynamic> readAftercare();
  void updateAftercare();
  void deleteAftercare(String aftercareId);

  // Client
  void createClient(Client client);
  Future<Client> readClient(String clientId);
  void updateClient(Client client);
  void deleteClient(String clientId);

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

  // Dietician
  void createDietician();
  Future<dynamic> readDietician();
  void updateDietician();
  void deleteDietician(String dieticianId);
}