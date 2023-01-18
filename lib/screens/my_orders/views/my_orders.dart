import 'package:fhemtni/screens/my_orders/models/my_orders_model.dart';
import 'package:fhemtni/screens/my_orders/cards/order_card.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  static void create(BuildContext context, {bool returnBack = true}) {
    if (returnBack) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<MyOrdersModel>(
                    create: (context) => MyOrdersModel(),
                    child: Consumer<MyOrdersModel>(
                      builder: (context, model, _) {
                        return MyOrders._(
                          model: model,
                          canReturnBack: returnBack,
                        );
                      },
                    ),
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<MyOrdersModel>(
                    create: (context) => MyOrdersModel(),
                    child: Consumer<MyOrdersModel>(
                      builder: (context, model, _) {
                        return MyOrders._(
                          model: model,
                          canReturnBack: returnBack,
                        );
                      },
                    ),
                  )));
    }
  }

  final MyOrdersModel model;
  final bool canReturnBack;

  const MyOrders._({Key? key, required this.model, required this.canReturnBack})
      : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
        title: const Text("My orders"),
        centerTitle: true,
        actions: !widget.canReturnBack
            ? [
                IconButton(
                  onPressed: () {
                    final auth=GetIt.I.get<Auth>();
                    auth.signOut(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  tooltip: "Logout",
                ),
              ]
            : [],
      ),
      body: widget.model.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                top: 20,
                left: MediaQuery.of(context).padding.left + 20,
                right: MediaQuery.of(context).padding.right + 20,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              itemBuilder: (context, position) {
                return OrderCard(order: widget.model.orders[position]);
              },
              itemCount: widget.model.orders.length,
            ),
    );
  }
}
