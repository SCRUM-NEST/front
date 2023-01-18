import 'package:auto_size_text/auto_size_text.dart';
import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/core/order.dart';
import 'package:fhemtni/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  static void create(BuildContext context, {required Order order}) {
    showDialog(context: context, builder: (context) => OrderDetails._(order: order));
  }

  final Order order;
  const OrderDetails._({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statues = {
      OrderStatus.pending: "Pending",
      OrderStatus.declined: "Declined",
      OrderStatus.delivered: "Delivered",
      OrderStatus.accpeted: "Accepted",
    };
    final themeModel = Provider.of<ThemeModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: themeModel.backgroundColor,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(
                  "#" + order.id.toString(),
                  style: themeModel.theme.textTheme.headline4,
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                order.specifications,
                style: themeModel.theme.textTheme.bodyText1,
              ),
            ),
            Center(
              child: Text(
                statues[order.status]!,
                style: themeModel.theme.textTheme.headline4?.copyWith(
                    color: order.status == OrderStatus.pending
                        ? Colors.orange
                        : order.status == OrderStatus.declined
                            ? Colors.red
                            : Colors.green),
              ),
            ),
            if (order.status == OrderStatus.pending)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child: DefaultButton(
                    height: 40,
                    child: const AutoSizeText("Cancel order"),
                    onPressed: () {},
                  ),
                ),
              ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "Ordered at: " + DateFormat("yyyy-MM-dd HH:mm").format(order.createdAt),
                style: themeModel.theme.textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
