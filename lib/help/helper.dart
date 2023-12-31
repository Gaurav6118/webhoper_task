import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webhoper_test/help/app_config.dart';

import '../repos/authentication_repository.dart';

// This class is using for toast messaging and any method call whole app
class Helper {
  BuildContext? context;

  Helper.of(BuildContext _context) {
    context = _context;
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout',
              style: TextStyle(
                  fontSize: AppConfig(context).appHeight(2.5),
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to Logout?',
                    style: TextStyle(
                        fontSize: AppConfig(context).appHeight(2.2),
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No',
                  style: TextStyle(
                      fontSize: AppConfig(context).appHeight(2.5),
                      color: AppColors().colorPrimary(1),
                      fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes',
                  style: TextStyle(
                      fontSize: AppConfig(context).appHeight(2.5),
                      color: AppColors().colorPrimary(1),
                      fontWeight: FontWeight.w500)),
              onPressed: () {
                context.read<AuthenticationRepository>().logOut();
              },
            ),
          ],
        );
      },
    );
  }

  static void showToast(dynamic message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors().colorPrimary(1),
    );
  }

  static void showLongToast(dynamic message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors().colorPrimary(1),
    );
  }

  static Widget showLoader({Color? color}) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration:
              BoxDecoration(color: color ?? AppColors().colorPrimary(1)),
        );
      },
    );
  }
}
