import 'dart:typed_data';

class Quot {
  final String quot;
  final String author;
  final Uint8List image;
  //final String image;

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
  //late String image;
  String? backgroungimage;

  DBQuot(
      {required this.image,
      required this.quot,
      required this.author,
      this.backgroungimage});

  factory DBQuot.fromJSON(Map data) {
    return DBQuot(
      image: data["image"],
      quot: data["quote"],
      author: data["author"],
      backgroungimage:
          "https://love-shayari.co/wp-content/uploads/2021/10/sun-rise.jpg",
    );
  }
}
