import 'package:pdg_app/model/client.dart';

abstract class IClient {
  void createClient(Client client);
  Future<Client> readClient(String clientId);
  void updateClient(Client client);
  void deleteClient(String clientId);
  Future<List<Client>> getDietitianClient(String dietitianId);
}