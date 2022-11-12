import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_quotes_and_sayings_app/screens/details%20of%20quote%20by%20category.dart';
import 'package:life_quotes_and_sayings_app/screens/home%20page.dart';
import 'package:life_quotes_and_sayings_app/screens/latest%20quotes.dart';
import 'package:life_quotes_and_sayings_app/screens/popular%20quotes.dart';
import 'package:life_quotes_and_sayings_app/screens/quotes%20by%20category.dart';
import 'package:life_quotes_and_sayings_app/screens/splash%20Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      routes: {
        '/home_page': (context) => const HomePage(),
        '/quotes_by_category': (context) => const QuotesByCategory(),
        '/popular_quotes': (context) => const PopularQuotes(),
        '/latest_quotes': (context) => const LatestQuotes(),
        '/details_of_category': (context) => const DetailsOfCategory(),
        '/splash_screen': (context) => const SplashScreen(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
        ),
      ),
    );
  }
}
