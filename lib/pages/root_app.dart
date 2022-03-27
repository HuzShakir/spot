import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  void getImages() async {
    final credentials = SpotifyApiCredentials(
        "d58296fd034f4208b15dd0801bc36a7c", "bd41522a547f4238abcd39b623379def");
    final spotify = SpotifyApi(credentials);
    var res = await spotify.search.get("thats what i want").first(2);
    res.forEach((pages) {
      pages.items!.forEach((item) {
        if (item is PlaylistSimple) {
          print('Playlist: \n'
              'id: ${item.id}\n'
              'name: ${item.name}:\n'
              'collaborative: ${item.collaborative}\n'
              'href: ${item.href}\n'
              'trackslink: ${item.tracksLink!.href}\n'
              'owner: ${item.owner}\n'
              'public: ${item.owner}\n'
              'snapshotId: ${item.snapshotId}\n'
              'type: ${item.type}\n'
              'uri: ${item.uri}\n'
              'images: ${item.images!.length>0 ? item.images![0].url:0}\n'
              '-------------------------------');
        }
        // return await spotify.search.get("thats what i want").first(2);
      });
    });
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
        SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello " + FirebaseAuth.instance.currentUser!.uid),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                child: Text("Log out"),
                // width: double.infinity,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                    color: Color.fromRGBO(30, 215, 96, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            InkWell(
              onTap: () async {
                print("object");
                getImages();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                child: Text("Check karto"),
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
        ))
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
      Feather.settings,
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
