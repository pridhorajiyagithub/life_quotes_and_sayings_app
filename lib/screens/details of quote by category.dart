import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_quotes_and_sayings_app/widgets/download_image.dart';

import '../global.dart';
import '../helpers/db_helper.dart';
import '../model/quot.dart';
import '../widgets/copy_quote.dart';

class DetailsOfCategory extends StatefulWidget {
  const DetailsOfCategory({Key? key}) : super(key: key);

  @override
  State<DetailsOfCategory> createState() => _DetailsOfCategoryState();
}

class _DetailsOfCategoryState extends State<DetailsOfCategory> {
  Uint8List? image;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Global.tableName,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: DBHelper.dbHelper.fetchAllRecords(tableName: Global.tableName),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<DBQuot>? res = snapShot.data;
            int? randomIndex = random.nextInt(res!.length);
            DBQuot randomImage = res[randomIndex];

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: res!.length,
              itemBuilder: (context, i) {
                image = res[i].image;
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Global.selectedQuote = res[i];
                      Navigator.of(context)
                          .pushNamed("/final_output", arguments: res[i]);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 350,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.6),
                                        BlendMode.hardLight,
                                      ),
                                      fit: BoxFit.cover,
                                      image: MemoryImage(
                                        image!,
                                      ),
                                    ),
                                  ),
                                  height: 350,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    res[i].quot,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                /* Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100))),
                                )*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapShot.hasError) {
            return Center(
              child: Text("${snapShot.error}"),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
