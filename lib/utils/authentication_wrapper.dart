import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticked/models/custom_user.dart';
import 'package:ticked/pages/auth/authentication_page.dart';
import 'package:ticked/pages/home/home_page.dart';
import 'package:ticked/pages/home/user_data_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customUser = Provider.of<CustomUser?>(context);

    if (customUser == null) {
      return const AuthenticationPage();
    }
    if (customUser.status == false && customUser != null) {
      return const UserDataPage();
    } else {
      return const HomePage();
    }
  }
}
