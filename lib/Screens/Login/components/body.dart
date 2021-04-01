import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Support/support.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.01),
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/sl_police.png",
              height: size.height * 0.34,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Officer ID",
              onChanged: (value) {
                id = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                pass = value;
              },
            ),
            RoundedButton(
                text: "LOGIN",
                // navigate to page after login
                press: () {
                  /*
               */
                  login();
                }),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SupportScreen();
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

  String id;
  String pass;

  void login() {
    bool found = false;

    try {
      FirebaseFirestore.instance.collection("officer").get().then((value) {
        for (int a = 0; a < value.docs.length; a++) {
          if (value.docs[a].id == id) {
            if (value.docs[a]["password"] == pass) {
              print("Found");
              found = true;
              break;
            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Error',
                desc: 'Incorrect ID or Password',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
            }
          }
        }

        if (!found) {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.ERROR,
            body: Center(
              child: Text(
                'Incorrect ID or Password',
                style: TextStyle(),
              ),
            ),
            title: 'This is Ignored',
            desc: 'This is also Ignored',
            btnOkOnPress: () {},
            btnOkColor: Color(0xFF3F51B5),
          )..show();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Dashboard();
              },
            ),
          );
        }
      });
    } catch (e) {
      String error = e;
      print(error);
    }
  }
}
