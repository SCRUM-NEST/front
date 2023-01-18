import 'package:fhemtni/screens/home_page/cards/retailer_card.dart';
import 'package:fhemtni/screens/home_page/models/home_page_model.dart';
import 'package:fhemtni/screens/my_orders/views/my_orders.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:fhemtni/transitions/fade_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static void create(BuildContext context) {
    Navigator.pushReplacement(
        context,
        FadeRoute(
            page: ChangeNotifierProvider<HomePageModel>(
          create: (context) => HomePageModel(),
          child: Consumer<HomePageModel>(builder: ((context, model, _) {
            return HomePage._(model: model);
          })),
        )));
  }

  final HomePageModel model;
  const HomePage._({Key? key, required this.model}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.model.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                MyOrders.create(context);
              },
              icon: const Icon(Icons.list),
              tooltip: "My orders",
            ),
            IconButton(
              onPressed: () {
                final auth = GetIt.I.get<Auth>();
                auth.signOut(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              tooltip: "Logout",
            ),
          ],
        ),
        body: widget.model.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                itemBuilder: (context, position) {
                  return RetailerCard(
                      retailer: widget.model.retailers[position]);
                },
                itemCount: widget.model.retailers.length,
              ));
  }
}
