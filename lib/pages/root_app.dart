import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:spot/pages/Profile_page.dart';
import 'package:spot/pages/home_page.dart';
import 'package:spot/pages/search_page.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/theme/colors.dart';
import 'package:spotify/spotify.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  late SpotifyApi spotify;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(spotify.search.get("thats what i want").first(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),
        Center(
          child: Text(
            "Library",
            style: TextStyle(
                fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
        ),
        SearchPage(),
        ProfilePage()
        // SafeArea(
        //     child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text("Hello " + FirebaseAuth.instance.currentUser!.uid),
        //     InkWell(
        //       onTap: () async {
        //         await FirebaseAuth.instance.signOut();
        //         Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(
        //             builder: (context) => LoginScreen(),
        //           ),
        //         );
        //       },
        //       child: Container(
        //         margin: EdgeInsets.symmetric(vertical: 25),
        //         child: Text("Log out"),
        //         // width: double.infinity,
        //         padding: EdgeInsets.all(12),
        //         alignment: Alignment.center,
        //         decoration: const ShapeDecoration(
        //             color: Color.fromRGBO(30, 215, 96, 1),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(5)),
        //             )),
        //       ),
        //     ),
            
        //   ],
        // )
        // )
        // Center(
        //   child: Text(
        //     "Setting",
        //     style: TextStyle(
        //         fontSize: 20, color: white, fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Feather.home,
      Feather.book,
      Feather.search,
      Feather.user,
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return IconButton(
                key: Key("item $index"),
                  icon: Icon(
                    items[index],
                    color: activeTab == index ? primary : white,
                  ),
                  onPressed: () {
                    setState(() {
                      activeTab = index;
                    });
                  });
            })),
      ),
    );
  }
}
