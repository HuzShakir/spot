import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ftfrd friends welcome to my youtube channel" +
              FirebaseAuth.instance.currentUser!.uid),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              child: Text("Log out kar chal"),
              // width: double.infinity,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                  color: Color.fromRGBO(30, 215, 96, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          )
        ],
      )),
    );
  }
}
