import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/background.dart';
import 'package:flutter_auth/Screens/Driver/driver.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.04),
            Text(
              "DASHBOARD",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.04),
            SvgPicture.asset(
              "assets/icons/scan.svg",
              height: size.height * 0.35,
              color: kPrimaryLightColor,
            ),
            SizedBox(height: size.height * 0.06),
            Text(
              "Scan driver licence with NFC to access profile!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "COMPLETE SCAN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DriverScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "MY PROFILE",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {},
            ),
            RoundedButton(
              text: "LOGOUT",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
