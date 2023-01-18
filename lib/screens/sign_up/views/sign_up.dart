import 'package:fhemtni/common/theme_model.dart';
import 'package:fhemtni/screens/sign_in/views/sign_in.dart';
import 'package:fhemtni/screens/sign_up/models/sign_up_model.dart';
import 'package:fhemtni/utils/validators.dart';
import 'package:fhemtni/widgets/buttons/default_button.dart';
import 'package:fhemtni/widgets/text_fields/default_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../utils/loading_screen.dart';

class SignUp extends StatefulWidget {
  static void create(BuildContext context, {bool returnBack = true}) {
    if (returnBack) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return ChangeNotifierProvider<SignUpModel>(
          create: (context) => SignUpModel(),
          child: Consumer<SignUpModel>(
            builder: (context, model, _) {
              return SignUp._(model: model);
            },
          ),
        );
      }));
    } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
        return ChangeNotifierProvider<SignUpModel>(
          create: (context) => SignUpModel(),
          child: Consumer<SignUpModel>(
            builder: (context, model, _) {
              return SignUp._(model: model);
            },
          ),
        );
      }));
    }
  }

  final SignUpModel model;

  const SignUp._({Key? key, required this.model}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController roleController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FocusNode roleFocus = FocusNode();

  final FocusNode emailFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
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

                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(),
                ),

                ///First name text field
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DefaultTextField(
                      onTap: () {
                        widget.model.requestFocus(context, usernameFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.requestFocus(context, emailFocus);
                      },
                      validator: (value) {
                        if (value != null && Validators.username(value)) {
                          return null;
                        }
                        return "Please enter a valid username";
                      },
                      focusNode: usernameFocus,
                      controller: usernameController,
                      hintText: "Username",
                      isLoading: widget.model.isLoading,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      icon: const Icon(
                        Icons.person_outline,
                        size: 18,
                      ),
                      keyboardType: TextInputType.text),
                ),

                ///Email text field
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DefaultTextField(
                      onTap: () {
                        widget.model.requestFocus(context, emailFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.requestFocus(context, roleFocus);
                      },
                      validator: (value) {
                        if (value != null && Validators.email(value)) {
                          return null;
                        }
                        return "Pleas eenter a valid email address";
                      },
                      focusNode: emailFocus,
                      controller: emailController,
                      hintText: "Email address",
                      isLoading: widget.model.isLoading,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      icon: const Icon(
                        Icons.email_outlined,
                        size: 18,
                      ),
                      keyboardType: TextInputType.emailAddress),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DefaultTextField(
                      onTap: () {
                        widget.model.requestFocus(context, roleFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.requestFocus(context, passwordFocus);
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Please enter a valid role";
                      },
                      focusNode: roleFocus,
                      controller: roleController,
                      hintText: "Role",
                      isLoading: widget.model.isLoading,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      icon: const Icon(
                        Icons.person_outline,
                        size: 18,
                      ),
                      keyboardType: TextInputType.text),
                ),

                ///Password text field
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DefaultTextField(
                      onTap: () {
                        widget.model.requestFocus(context, passwordFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.requestFocus(context, confirmPasswordFocus);
                      },
                      validator: (value) {
                        if (value != null && Validators.password(value)) {
                          return null;
                        }
                        return "Please enter a valid password";
                      },
                      focusNode: passwordFocus,
                      controller: passwordController,
                      hintText: "Password",
                      isLoading: widget.model.isLoading,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      obscureText: widget.model.obscurePassword ? true : false,
                      icon: const Icon(
                        Icons.lock_outline,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.model.changePasswordVisibility();
                        },
                        icon: Icon(widget.model.obscurePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                      keyboardType: TextInputType.text),
                ),

                ///Confirm Password text field
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: DefaultTextField(
                      focusNode: confirmPasswordFocus,
                      controller: confirmPasswordController,
                      hintText: "Confirm password",
                      isLoading: widget.model.isLoading,
                      validator: (value) {
                        if (value != null &&
                            Validators.password(value) &&
                            passwordController.text == confirmPasswordController.text) {
                          return null;
                        } else if (value == null || !Validators.password(value)) {
                          return "Please enter a valid password";
                        }
                        return "Passwords didn't match";
                      },
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      onTap: () {
                        widget.model.requestFocus(context, confirmPasswordFocus);
                      },
                      onSubmitted: (value) {
                        widget.model.removeFocus(context);

                        if (!widget.model.isLoading && _formKey.currentState!.validate()) {
                           widget.model.submit(context,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    role: roleController.text);
                        }
                      },
                      obscureText: widget.model.obscureConfirmPassword ? true : false,
                      icon: const Icon(
                        Icons.lock_outline,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.model.changeConfirmPasswordVisibility();
                        },
                        icon: Icon(widget.model.obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
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
                              if (_formKey.currentState!.validate()) {
                                widget.model.submit(context,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    role: roleController.text);
                              }
                            },
                      child: !widget.model.isLoading
                          ? const Text(
                              "Sign up",
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

                ///Do you have an account
                Center(
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'Do you have an account? ', style: themeModel.theme.textTheme.bodyText1),
                      TextSpan(
                        text: "Sign in",
                        style: themeModel.theme.textTheme.headline5!.apply(color: themeModel.accentColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (!widget.model.isLoading) {
                              SignIn.create(context, returnBack: false);
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
