import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/provider/client_list_provider.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:provider/provider.dart';

import '../model/client.dart';
import '../widgets/client_list.dart/top_shape.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ClientListProvider(dietitianUid: ""), //TODO changer l'id
      builder: ((context, child) => ClientList(
            searchController: _searchController,
            onSearchBarUpdate: () {
              Provider.of<ClientListProvider>(context, listen: false)
                  .filterClients(_searchController.text);

              // setState(() {});
            },
          )),
      // child: ClientList(
      //   searchController: _searchController,
      // ),
    );
  }
}

class ClientList extends StatefulWidget {
  final double _screenWidth;
  final TextEditingController _searchController;
  final void Function() _onSearchBarUpdate;

  const ClientList({
    screenWidth = 0.0,
    required searchController,
    required onSearchBarUpdate,
    Key? key,
  })  : _screenWidth = screenWidth,
        _searchController = searchController,
        _onSearchBarUpdate = onSearchBarUpdate,
        super(key: key);

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  late List<Client> filteredClients;
  late String query;

  @override
  void initState() {
    // filteredClients = widget._clients;
    // query = "";

    widget._searchController.addListener(() {
      widget._onSearchBarUpdate();
      // context
      //     .watch<ClientListProvider>()
      //     .filterClients(widget._searchController.text);

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget._searchController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget._screenWidth == 0
        ? MediaQuery.of(context).size.width
        : widget._screenWidth;

    final height = (width * 0.19444444444444445).toDouble();

    return Column(
      children: [
        CustomPaint(
          size: Size(width,
              height), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: ClientListTopShape(),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clients",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              MainTextField(
                name: "Search client",
                icon: const Icon(Icons.search),
                controller: widget._searchController,
              )
            ],
          ),
        ),
        context.watch<ClientListProvider>().isLoading == false
            ? ScrollableClientList(
                clients: context.watch<ClientListProvider>().filteredClients)
            : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
      ],
    );
  }
}

class ScrollableClientList extends StatelessWidget {
  final List<Client> _clients;

  const ScrollableClientList({
    required clients,
    Key? key,
  })  : _clients = clients,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          itemBuilder: ((context, index) => ArrowPicCard(
              title: Text(
                  "${_clients[index].firstName} ${_clients[index].lastName}"))),
          separatorBuilder: ((context, index) => const SizedBox(height: 15)),
          itemCount: _clients.length),
    );
  }
}
