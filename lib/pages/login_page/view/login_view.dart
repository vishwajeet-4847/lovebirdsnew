import 'package:figgy/firebase/firebase_access_token.dart';
import 'package:figgy/firebase/firebase_uid.dart';
import 'package:figgy/pages/login_page/api/login_api.dart';
import 'package:figgy/pages/login_page/model/login_model.dart';
import 'package:figgy/pages/login_page/widget/login_button_widget.dart';
import 'package:figgy/pages/login_page/widget/login_logo_widget.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _image = const AssetImage(AppAsset.imageBackground1);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _image,
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          children: [
            LoginLogoWidget(),
            Spacer(),
            LoginButtonWidget(),
          ],
        ),
      ),
    );
  }
}
