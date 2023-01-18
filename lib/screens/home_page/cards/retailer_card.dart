import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/core/retailer.dart';
import 'package:fhemtni/screens/submit_order/views/submit_order.dart';
import 'package:fhemtni/widgets/bounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RetailerCard extends StatelessWidget {
  final Retailer retailer;
  const RetailerCard({Key? key, required this.retailer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Bounce(
          onPressed: () {
            SubmitOrder.create(context, retailer: retailer);
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
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(color: themeModel.accentColor, borderRadius: BorderRadius.circular(10)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        retailer.firstName + " " + retailer.lastName,
                        style: themeModel.theme.textTheme.headline4,
                      ),
                      Text(
                        "Clothing",
                        style: themeModel.theme.textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 18,
                ),
                Text(
                  "4.2(70)",
                  style: themeModel.theme.textTheme.headline4
                      ?.copyWith(fontWeight: FontWeight.normal, color: Colors.orange),
                )
              ],
            ),
          )),
    );
  }
}
