import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spot/models/Song.dart' as model;
import 'package:spotify/spotify.dart';

Future<List> fetchSong(searchString) async {
  final credentials = SpotifyApiCredentials(
      "d58296fd034f4208b15dd0801bc36a7c", "bd41522a547f4238abcd39b623379def");
  final spotify = SpotifyApi(credentials);
  var uri = Uri.parse(
      "https://myfreemp3juices.cc/api/search.php?callback=jQuery213046606674582949026_1640356915467");
  var headers = {
    'authority': 'myfreemp3juices.cc',
    'pragma': 'no-cache',
    'cache-control': 'no-cache',
    'accept':
        'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01',
    'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
    'x-requested-with': 'XMLHttpRequest',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Android"',
    'origin': 'https://myfreemp3juices.cc',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'sec-fetch-dest': 'empty',
    'referer': 'https://myfreemp3juices.cc/',
    'accept-language': 'en-US,en;q=0.9',
    'cookie':
        'musicLang=en; _ga=GA1.1.826251306.1640356582; _ga_DYZZKHXHHL=GS1.1.1640356582.1.1.1640356915.0; prefetchAd_3606797=true',
  };
  final response = await http
      .post(uri, headers: headers, body: {'q': searchString, 'page': '0'});
  print(response.statusCode);
  if (response.statusCode == 200) {
    List songs = jsonDecode(
            response.body.substring(42, response.body.length - 4))['response']
        .sublist(1)
        .map((song) {
      // print(getImages(song['title']));
      print(model.Song.fromJson(song).artist);
      return model.Song.fromJson(song);
      try {} catch (e) {}
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
