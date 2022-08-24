import '../model/client.dart';

abstract class Api {
  // Auth
  signIn();
  signOut();

  // Aftercare
  createAftercare();
  readAftercare();
  updateAftercare();
  deleteAftercare();

  // Client
  void createClient(Client client);
  Future<Client> readClient();
  void updateClient();
  void deleteClient();

  // Document
  void createDocument();
  Future<dynamic> readDocument();
  void updateDocument();
  void deleteDocument();

  // Meal
  void createMeal();
  Future<dynamic> readMeal();
  void updateMeal();
  void deleteMeal();

  // Message
  void createMessage();
  Future<dynamic> readMessage();
  void updateMessage();
  void deleteMessage();

  // Dietician
  void createDietician();
  Future<dynamic> readDietician();
  void updateDietician();
  void deleteDietician();
}
