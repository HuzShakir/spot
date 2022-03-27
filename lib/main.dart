import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spot/pages/root_app.dart';
import 'package:spot/responsive/mobile_screen_layout.dart';
import 'package:spot/responsive/responsive_layout.dart';
import 'package:spot/responsive/webscreen_layout.dart';
import 'package:spot/screens/landing_screen.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/screens/register_screen.dart';
import 'package:spot/screens/signUp_screen.dart';
import 'package:spot/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify/spotify.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Ela kem se'),
        // ),
        // body: const Center(
        //   child: ResponsiveLayout(
        //       mobileScreenLayout: MobileScreenLayout(),
        //       webscreenLayout: WebScreenLayout()),
        // ),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return RootApp();
                // return SafeArea(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //     Text("ftfrd friends welcome to my youtube channel" +
                //         FirebaseAuth.instance.currentUser!.uid),
                //     InkWell(
                //       onTap: () async {
                //         await FirebaseAuth.instance.signOut();
                //       },
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 25),
                //         child: Text("Log out kar chal"),
                //         // width: double.infinity,
                //         padding: EdgeInsets.all(12),
                //         alignment: Alignment.center,
                //         decoration: const ShapeDecoration(
                //             color: Color.fromRGBO(30, 215, 96, 1),
                //             shape: RoundedRectangleBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(5)),
                //             )),
                //       ),
                //     )
                //   ],
                // ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return LoginScreen();
          },
        ),
      ),
    );
  }
}
