import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_quotes_and_sayings_app/helpers/db_helper.dart';
import 'package:life_quotes_and_sayings_app/model/quot.dart';
import '../global.dart';
import '../widgets/copy_quote.dart';
import '../widgets/download_image.dart';

class FinalOutput extends StatefulWidget {
  const FinalOutput({Key? key}) : super(key: key);

  @override
  State<FinalOutput> createState() => _FinalOutputState();
}

class _FinalOutputState extends State<FinalOutput> {
  List<String> fontList = [
    'Sono',
    'Rubic',
    'Oswald',
    'NotoSans',
    'Teko',
    'Lobster'
  ];
  String isSelect = 'Rubic';

  List<bool> isSelected =
      List.generate(Global.quoteCategory.length, (index) => false);
  bool onselected = false;
  Random random = Random();
  Uint8List? vlist;
  List<Uint8List> all = [];
  //List<String> all = [];
  String name = "poppins";
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    DBQuot args = ModalRoute.of(context)!.settings.arguments as DBQuot;
    int? randomIndex = random.nextInt(Global.editorImageList.length);
    String randomImage = Global.editorImageList[randomIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Make Quotes image",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                height: 650,
                width: double.infinity,
                decoration: (isChanged == false)
                    ? BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.hardLight,
                            ),
                            image: MemoryImage(
                              args.image!,
                            ),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.hardLight,
                            ),
                            image: NetworkImage(args.backgroungimage!),

                            /*MemoryImage(
                      args.image!,
                    ),*/
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: (isChanged == false)
                    ? Text(
                        args.quot,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        args.quot,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: isSelect,
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      /*  int randomIndex =
                          random.nextInt(Global.editorImageList.length);
                      randomImage = Global.editorImageList[randomIndex];
                      List<int> list = randomImage.codeUnits;
                      Uint8List changedImage = Uint8List.fromList(list);

                      for (int i = 0; i < Global.editorImageList.length; i++) {
                        vlist = (await NetworkAssetBundle(
                                    Uri.parse(Global.editorImageList[i]))
                                .load(Global.editorImageList[i]))
                            .buffer
                            .asUint8List();
                      }
                      Uint8List result =
                          await FlutterImageCompress.compressWithList(
                        vlist!,
                        minHeight: 1920,
                        minWidth: 1080,
                        quality: 96,
                        rotate: 135,
                      );
                      setState(
                        () {
                          i = result;
                        },
                      );*/

                      setState(
                        () {
                          isChanged = true;
                          args.backgroungimage = (Global.editorImageList
                                      .indexOf(args.backgroungimage!) ==
                                  Global.editorImageList.length - 1)
                              ? Global.editorImageList[0]
                              : Global.editorImageList[Global.editorImageList
                                      .indexOf(args.backgroungimage!) +
                                  1];

                          isSelect = (fontList.indexOf(isSelect) ==
                                  fontList.length - 1)
                              ? fontList[0]
                              : fontList[fontList.indexOf(isSelect) + 1];
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      copyQuote(
                        context: context,
                        res: args,
                      );
                    },
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ImageDownloader(
                        context: context,
                        res: args,
                        isShare: true,
                      );
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ImageDownloader(
                        context: context,
                        res: args,
                        isShare: false,
                      );
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onselected = !onselected;
                      });
                    },
                    icon: (onselected == true)
                        ? const Icon(
                            Icons.star,
                            color: Colors.redAccent,
                          )
                        : const Icon(
                            Icons.star_border,
                            color: Colors.teal,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
