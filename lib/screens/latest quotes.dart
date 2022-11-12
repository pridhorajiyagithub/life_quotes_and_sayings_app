import 'package:flutter/material.dart';

import '../global.dart';
import '../helpers/db_helper.dart';
import '../model/quot.dart';
import '../widgets/copy_quote.dart';
import '../widgets/download_image.dart';

class LatestQuotes extends StatefulWidget {
  const LatestQuotes({Key? key}) : super(key: key);

  @override
  State<LatestQuotes> createState() => _LatestQuotesState();
}

class _LatestQuotesState extends State<LatestQuotes> {
  List<Future<List<DBQuot>>> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < Global.quoteCategory.length; i++) {
      data.add(DBHelper.dbHelper
          .fetchAllRecords(tableName: Global.quoteCategory[i].category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Popular Quotes",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: data.map((e) {
            return FutureBuilder(
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  List<DBQuot>? res = snapShot.data;

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: res!.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.all(15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Global.selectedQuote = res[i];
                              Navigator.of(context).pushNamed("details_page");
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
                                height: 420,
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.6),
                                                BlendMode.hardLight,
                                              ),
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                res[i].image,
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
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.image,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              copyQuote(
                                                context: context,
                                                res: res[i],
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
                                                res: res[i],
                                                isShare: false,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                              color: Colors.green,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.star_border,
                                                color: Colors.teal,
                                              )),
                                          IconButton(
                                            onPressed: () {
                                              ImageDownloader(
                                                context: context,
                                                res: res[i],
                                                isShare: true,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapShot.hasError) {
                  return const Center(
                      // child: Text("${snapShot.error}"),
                      );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
