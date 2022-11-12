import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_quotes_and_sayings_app/helpers/random_quote_api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/home_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: RandomApiQuote.randomApiQuote.fetchQuote(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              String? res = snapShot.data;
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]
                    .withOpacity(0.5),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        res!,
                        style: GoogleFonts.pacifico(
                            fontSize: 35, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Life Quotes",
                        style: GoogleFonts.pacifico(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
