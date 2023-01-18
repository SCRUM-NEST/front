import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/core/order.dart';
import 'package:fhemtni/screens/my_orders/views/order_details.dart';
import 'package:fhemtni/widgets/bounce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statues = {
      OrderStatus.pending: "Pending",
      OrderStatus.declined: "Declined",
      OrderStatus.delivered: "Delivered",
      OrderStatus.accpeted: "Accepted",
    };

    final themeModel = Provider.of<ThemeModel>(context);
    return Bounce(
        onPressed: () {
          OrderDetails.create(context, order: order);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(blurRadius: 2, offset: const Offset(1, 1), color: themeModel.shadowColor),
              ],
              color: themeModel.backgroundColor),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "#" + order.id.toString(),
                      style: themeModel.theme.textTheme.headline2,
                    ),
                  ),
                  Text(
                    statues[order.status]!,
                    style: themeModel.theme.textTheme.headline4?.copyWith(
                        color: order.status == OrderStatus.pending
                            ? Colors.orange
                            : order.status == OrderStatus.declined
                                ? Colors.red
                                : Colors.green),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  DateFormat("yyyy-MM-dd HH:mm").format(order.createdAt),
                  style: themeModel.theme.textTheme.caption,
                ),
              )
            ],
          ),
        ));
  
  }
}
