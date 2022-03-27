import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spot/models/Song.dart' as model;
import 'package:spotify/spotify.dart';

Future<List> fetchSong(searchString) async {
  final credentials = SpotifyApiCredentials(
      "d58296fd034f4208b15dd0801bc36a7c", "bd41522a547f4238abcd39b623379def");
  final spotify = SpotifyApi(credentials);
  var uri = Uri.parse("http://192.168.0.104:5000/song/${searchString}");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List songs = jsonDecode(response.body)['response'].sublist(1).map((song) {
      // print(getImages(song['title']));
        print(model.Song.fromJson(song).artist);
        return model.Song.fromJson(song);
      try {
      } catch (e) {}
    }).toList();

    return songs;
    // model.Song song = model.Song.fromJson(jsonDecode(response.body));
    // print(song.url);
  } else {
    return [];
  }
}

Future<String> getImages(title) async {
  final credentials = SpotifyApiCredentials(
      "d58296fd034f4208b15dd0801bc36a7c", "bd41522a547f4238abcd39b623379def");
  final spotify = SpotifyApi(credentials);
  try {
    var image = await spotify.search.get(title).first(2);
    var url;
    image[0].items!.forEach((item) {
      if (item is AlbumSimple) {
        url = item.images![0].url;
        // return await spotify.search.get("thats what i want").first(2);
      }
    });
    var a = image[0].items!.elementAt(1);
    print(a);
    return url;
  } catch (e) {
    return "";
  }
}
