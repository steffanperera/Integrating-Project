import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/body.dart';
import 'package:flutter_auth/Screens/Driver/components/static.dart';
import 'package:flutter_auth/Screens/Driver/driver.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

String cardId;

class _NfcScanState extends State<Dashboard> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Body(),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    FlutterNfcReader.onTagDiscovered().listen((onData) {
      setState(() {});

      cardId = onData.id.toString();
      checkcard();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.

    super.dispose();
  }

  void checkcard() {
    String money;
    bool found = false;

    FirebaseFirestore.instance.collection("driver").get().then((value) {
      for (int a = 0; a < value.docs.length; a++) {
        if (cardId == value.docs[a]["nfc"]) {
          Static.id = value.docs[a].id;
          print(Static.id);
          found = true;
          break;
        }
      }

      if (found) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DriverScreen();
              },
            ),
          );
        });
      } else {
        setState(() {});
      }
    });
  }

  void back() {
    Navigator.of(context).pop();
  }
}
