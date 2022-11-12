import 'dart:convert';

import 'package:http/http.dart' as http;

class RandomApiQuote {
  RandomApiQuote._();
  static final RandomApiQuote randomApiQuote = RandomApiQuote._();
  String quote = "";

  Future<String> fetchQuote() async {
    http.Response res =
        await http.get(Uri.parse("https://zenquotes.io/api/quotes/random"));

    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);

      for (int i = 0; i < data.length; i++) {
        quote = data[i]["q"];
      }
    }
    return quote;
  }
}
