import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/core/retailer.dart';
import 'package:fhemtni/screens/sign_in/models/sign_in_model.dart';
import 'package:fhemtni/screens/sign_up/views/sign_up.dart';
import 'package:fhemtni/screens/submit_order/models/submit_order_model.dart';
import 'package:fhemtni/utils/loading_screen.dart';
import 'package:fhemtni/utils/validators.dart';
import 'package:fhemtni/widgets/buttons/default_button.dart';
import 'package:fhemtni/widgets/text_fields/default_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SubmitOrder extends StatefulWidget {
  static void create(BuildContext context, {required Retailer retailer}) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return ChangeNotifierProvider<SubmitOrderModel>(
        create: (context) => SubmitOrderModel(retailer.id),
        child: Consumer<SubmitOrderModel>(
          builder: (context, model, _) {
            return SubmitOrder._(model: model);
          },
        ),
      );
    }));
  }

  final SubmitOrderModel model;

  const SubmitOrder._({Key? key, required this.model}) : super(key: key);

  @override
  _SubmitOrderState createState() => _SubmitOrderState();
}

class _SubmitOrderState extends State<SubmitOrder> {
  final TextEditingController specificationController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  final FocusNode specificationFocus = FocusNode();
  final FocusNode costFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    specificationController.dispose();
    costController.dispose();
    specificationFocus.dispose();
    costFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit an order"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ///specifaitonb field
            DefaultTextField(
                validator: (value) {
                  if (value != null && value.length > 30) {
                    return null;
                  }
                  return "Please enter a valid specication(min length 30)";
                },
                focusNode: specificationFocus,
                controller: specificationController,
                hintText: "Specifications",
                isLoading: widget.model.isLoading,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 5,
                keyboardType: TextInputType.multiline),

            ///coist text field
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: DefaultTextField(
                  focusNode: costFocus,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return "Please enter a valid cost";
                  },
                  controller: costController,
                  hintText: "Estimated cost(in dt)",
                  isLoading: widget.model.isLoading,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number),
            ),

            ///Submit button
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: DefaultButton(
                  color: themeModel.accentColor,
                  onPressed: widget.model.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            widget.model.submit(context,
                                description: specificationController.text,
                                cost: costController.text);
                          }
                        },
                  child: !widget.model.isLoading
                      ? const Text(
                          "Order",
                        )
                      : Container(
                          padding: const EdgeInsets.all(5),
                          width: 32,
                          height: 32,
                          child: const LoadingScreen(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
