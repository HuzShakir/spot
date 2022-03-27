import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot/api/fetch_song.dart';
import 'package:spot/pages/music_detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spot/theme/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List> songs;
  late List<bool> fav;
  var issearch = false;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');
  final searchController = TextEditingController();
  Widget icon = Icon(IconData(0xe25c, fontFamily: 'MaterialIcons'));
  bool isfav = false;
  String search = "";
  Widget getBody = Text(
    "Yello",
    style: TextStyle(color: Colors.white),
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // songs = fetchSong("Me and My Broken Heart");
    if (search.isEmpty) {
      search = "Ela how are youu";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
            title: customSearchBar,
            backgroundColor: Color(0xff333333),
            actions: <Widget>[
              IconButton(
                icon: customIcon,
                tooltip: 'Search Song',
                onPressed: () {
                  if (customIcon.icon == Icons.search) {
                    setState(() {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar = ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          onSubmitted: (value) {
                            setState((() {
                              songs = fetchSong(value);
                              search = value;
                              songs.then((value) =>
                                  fav = List.filled(value.length, false));
                              issearch = true;
                              getBody = FutureBuilder<List>(
                                future: songs,
                                builder: (context, song) {
                                  if (song.hasData) {
                                    // setState(() {
                                    //   fav = List.filled(
                                    //       song.data?.length ?? 0, false);
                                    // });
                                    return ListView.builder(
                                      // Let the ListView know how many items it needs to build.
                                      itemCount: song.data?.length,
                                      // Provide a builder function. This is where the magic happens.
                                      // Convert each item into a widget based on the type of item it is.
                                      itemBuilder: (context, index) {
                                        final item = song.data?[index];

                                        return ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: MusicDetailPage(
                                                        id:item.id,
                                                        duration: item.duration,
                                                        title: item.title,
                                                        color:
                                                            Color(0xff000000),
                                                        description:
                                                            item.artist,
                                                        img:
                                                            "assets/images/img_5.jpg",
                                                        songUrl: item.url,
                                                      ),
                                                      type: PageTransitionType
                                                          .scale));
                                            },
                                            title: Text(item.title,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            subtitle: Text(item.artist,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            trailing: new IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  print(index);
                                                  fav[index] = !fav[index];
                                                });
                                              },
                                              icon: !fav[index]
                                                  ?new  Icon(Icons.favorite_border)
                                                  :new Icon(Icons.favorite),
                                            ),
                                            leading: ConstrainedBox(
                                              child: Image.asset(
                                                  "assets/images/img_1.jpg"),
                                              constraints: BoxConstraints(
                                                  minHeight: 44,
                                                  maxHeight: 64,
                                                  maxWidth: 64,
                                                  minWidth: 44),
                                            ));
                                      },
                                    );
                                  } else {
                                    return Text("Kai Search kar",
                                        style: TextStyle(color: Colors.white));
                                  }
                                },
                              );
                            }));
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Enter your song name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    });
                  } else {
                    setState(() {
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Search Song');
                    });
                  }
                  // handle the press
                },
              ),
            ]),
        body: getBody);
  }
}
