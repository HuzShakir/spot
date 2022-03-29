import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spot/model/User.dart' as model;
import 'package:spot/pages/music_detail_page.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late DocumentReference userdoc;
  late model.User user;
  @override
  void initState() {
    super.initState();
    userdoc = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);
    userdoc
        .collection("Liked Songs")
        .snapshots()
        .asyncMap((event) => print(event.docChanges));
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold),
            ),
            Icon(Feather.settings)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: FutureBuilder<DocumentSnapshot>(
            future: userdoc.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = model.User.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);
                return Column(
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                          child: Image.network(
                              auth.currentUser?.photoURL??"https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png")),
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.username,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                        margin: EdgeInsets.only(top: 25,left: 125,right: 125),
                        child: Text("Log out"),
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                            color: Color.fromRGBO(30, 215, 96, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Liked Songs",
                        style: TextStyle(
                            color: Color(0xffb3b3b3),
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: userdoc.collection("Liked Songs").snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snap) {
                            if (snap.hasError) {
                              return Text(
                                'Something went wrong',
                                style: TextStyle(color: white),
                              );
                            }

                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                "Loading",
                                style: TextStyle(color: white),
                                textAlign: TextAlign.left,
                              );
                            }
                            return ListView(
                                children: ListTile.divideTiles(
                                        context: context,
                                        tiles: snap.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;
                                          return ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: MusicDetailPage(
                                                        id: data['id'],
                                                        duration:
                                                            data['duration'],
                                                        title: data['title'],
                                                        color:
                                                            Color(0xff000000),
                                                        description:
                                                            data['artist'],
                                                        img:
                                                            "assets/images/img_5.jpg",
                                                        songUrl: data['url'],
                                                      ),
                                                      type: PageTransitionType
                                                          .scale));
                                            },
                                            title: Text(data['title'],
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            subtitle: Text(data['artist'],
                                                style: TextStyle(
                                                    color: grey)),
                                            leading: ConstrainedBox(
                                              child: Image.asset(
                                                  "assets/images/img_1.jpg"),
                                              constraints: BoxConstraints(
                                                  minHeight: 44,
                                                  maxHeight: 64,
                                                  maxWidth: 64,
                                                  minWidth: 44),
                                            ),
                                            minVerticalPadding: 15,
                                            trailing: new IconButton(
                                              onPressed: () {
                                                userdoc
                                                    .collection("Liked Songs")
                                                    .doc(data['id'].toString())
                                                    .delete();
                                              },
                                              icon: Icon(Icons.cancel_outlined),
                                            ),
                                            // title: Text(data['title'],style: TextStyle(color: white),),
                                            // subtitle: Text(data['artist'],style: TextStyle(color: white)),
                                          );
                                        }).toList())
                                    .toList());
                          }),
                    ),
                    
                  ],
                );
              }
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(
                  color: primary,
                ),
                height: 100,
                width: 100,
              ));
            }));
  }
}
