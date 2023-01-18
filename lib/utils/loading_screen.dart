import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color? color;
  final double strokeWidth;

  const LoadingScreen({Key? key, this.color, this.strokeWidth = 4.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              color: color,
            )
          : CircularProgressIndicator(
              color: color,
              strokeWidth: strokeWidth,
            ),
    );
  }
}
