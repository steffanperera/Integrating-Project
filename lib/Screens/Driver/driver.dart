import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class DriverScreen extends StatelessWidget {
  @override
  String p;
  TextEditingController pointsCon = TextEditingController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(0),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 30.00),
                    child: Text(
                      'DRIVER PROFILE',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SvgPicture.asset(
                  "assets/icons/licence.svg",
                  height: size.height * 0.35,
                  color: kPrimaryLightColor,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('driver')
                        .doc('d001')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var userDocument = snapshot.data;
                      p = userDocument["points"].toString();
                      return Column(children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '' + userDocument["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Driver Points: ' +
                                  userDocument["points"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              '' + userDocument["nic"],
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '' + userDocument["address"],
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '' + userDocument["birth"],
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Blood Group ' + userDocument["blood_group"],
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '' + userDocument["licence_no"],
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 50.00),
                            child: Text(
                              'STRIKE FINE ON LICENCE',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(height: size.height * 0.04),
                        SvgPicture.asset(
                          "assets/icons/fine.svg",
                          height: size.height * 0.25,
                          color: kPrimaryLightColor,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 26),
                            child: Text(
                              'Trafic Violation 1: -20 points',
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Trafic Violation 2: -40 points',
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Trafic Violation 3: -60 points',
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Severe Violation: Cancel Licence',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: pointsCon,
                            )),
                        SizedBox(height: size.height * 0.03),
                        RoundedButton(
                          text: "REDUCE POINTS",
                          press: () async {
                            reduce(context);
                          },
                        ),
                        RoundedButton(
                          text: "Back",
                          color: kPrimaryLightColor,
                          textColor: Colors.black,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Dashboard();
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.05),
                      ]);
                    })
              ],
            )),
      ),
    );
  }

  Future<void> reduce(BuildContext context) async {
    print(pointsCon.text);
    CollectionReference users = FirebaseFirestore.instance.collection('driver');

    int poin = int.parse(p) - int.parse(pointsCon.text);
    return users
        .doc('d001')
        .update({'points': poin})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
