import 'dart:typed_data';

class Quot {
  final String quot;
  final String author;
  final Uint8List image;

  Quot({required this.image, required this.quot, required this.author});

  factory Quot.fromJSON(Map data, Uint8List image) {
    return Quot(
      image: image,
      quot: data["content"],
      author: data["author"],
    );
  }
}

class DBQuot {
  final String quot;
  final String author;
  late Uint8List image;

  DBQuot({required this.image, required this.quot, required this.author});

  factory DBQuot.fromJSON(Map data) {
    return DBQuot(
      image: data["image"],
      quot: data["quote"],
      author: data["author"],
    );
  }
}
