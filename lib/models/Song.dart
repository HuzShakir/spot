class Song {
  final int duration;
  final String artist;
  final String title;
  final String url;
  final int id;
  // final String image;

  Song(this.duration, this.artist, this.title, this.url, this.id);

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      json['duration'],
      json['artist'],
      json['title'],
      json['url'],
      json['id']
      // json['image'],
    );
  }
}
