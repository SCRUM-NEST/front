import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/screens/sign_in/models/sign_in_model.dart';
import 'package:fhemtni/screens/sign_up/views/sign_up.dart';
import 'package:fhemtni/utils/loading_screen.dart';
import 'package:fhemtni/utils/validators.dart';
import 'package:fhemtni/widgets/buttons/default_button.dart';
import 'package:fhemtni/widgets/text_fields/default_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SignIn extends StatefulWidget {
  static void create(BuildContext context, {bool returnBack = true}) {
    if (returnBack) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return ChangeNotifierProvider<SignInModel>(
          create: (context) => SignInModel(),
          child: Consumer<SignInModel>(
            builder: (context, model, _) {
              return SignIn._(model: model);
            },
          ),
        );
      }));
    } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
        return ChangeNotifierProvider<SignInModel>(
          create: (context) => SignInModel(),
          child: Consumer<SignInModel>(
            builder: (context, model, _) {
              return SignIn._(model: model);
            },
          ),
        );
      }));
    }
  }

  final SignInModel model;

  const SignIn._({Key? key, required this.model}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async {
          if (widget.model.isLoading) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: ListView(
              padding: MediaQuery.of(context).padding.add(const EdgeInsets.all(20)),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (!widget.model.isLoading) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: themeModel.secondTextColor,
                        )),
                    Expanded(
                        child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: const AssetImage("assets/images/logo.png"),
                        width: width / 5,
                        fit: BoxFit.cover,
                      ),
                    )),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Login to your account",
                      style: themeModel.theme.textTheme.headline1!
                          .copyWith(fontSize: 30, fontWeight: FontWeight.w700, color: themeModel.accentColor),
                    ),
                  ),
                ),

                ///email field
                DefaultTextField(
                    onTap: () {
                      widget.model.requestFocus(context, usernameFocus);
                    },
                    onSubmitted: (value) {
                      widget.model.requestFocus(context, passwordFocus);
                    },
                    validator: (value) {
                      if (value != null && Validators.username(value)) {
                        return null;
                      }
                      return "Please enter a valid usernames";
                    },
                    focusNode: usernameFocus,
                    controller: usernameController,
                    hintText: "Username",
                    isLoading: widget.model.isLoading,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    icon: const Icon(
                      Icons.person,
                      size: 18,
                    ),
                    keyboardType: TextInputType.text),

                ///Password text field
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: DefaultTextField(
                      focusNode: passwordFocus,
                      onTap: () {
                        widget.model.requestFocus(context, passwordFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.removeFocus(context);
                        if (!widget.model.isLoading && _formKey.currentState!.validate()) {}
                      },
                      validator: (value) {
                        if (value != null && Validators.password(value)) {
                          return null;
                        }
                        return "Please enter a valid password";
                      },
                      controller: passwordController,
                      hintText: "Password",
                      isLoading: widget.model.isLoading,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      icon: const Icon(
                        Icons.lock_outline,
                        size: 18,
                      ),
                      obscureText: widget.model.obscurePassword ? true : false,
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.model.changePasswordVisibility();
                        },
                        icon: Icon(widget.model.obscurePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                      keyboardType: TextInputType.text),
                ),

                ///Submit button
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: DefaultButton(
                      color: themeModel.accentColor,
                      onPressed: widget.model.isLoading
                          ? null
                          : () {
                              widget.model.removeFocus(context);

                              if (_formKey.currentState!.validate()) {
                                widget.model.submit(context,
                                    username: usernameController.text, password: passwordController.text);
                              }
                            },
                      child: !widget.model.isLoading
                          ? const Text(
                              "Sign in",
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

                ///Do you haven't an account
                Center(
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(text: "Do you haven't an account? ", style: themeModel.theme.textTheme.bodyText1),
                      TextSpan(
                        text: "Sign up",
                        style: themeModel.theme.textTheme.headline5!.apply(color: themeModel.accentColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (!widget.model.isLoading) {
                              SignUp.create(context);
                            }
                          },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
