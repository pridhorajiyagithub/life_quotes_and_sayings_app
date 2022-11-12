import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';
import '../helpers/db_helper.dart';
import '../model/quot.dart';
import '../widgets/custom author container.dart';
import '../widgets/custom container.dart';
import '../widgets/drawer widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ));
        }),
        elevation: 0,
        title: Text(
          "Life Quotes and Sayings",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: DBHelper.dbHelper.fetchAllRecords(tableName: "Latest"),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    List<DBQuot>? res = snapShot.data;

                    return GestureDetector(
                      onTap: () {
                        Global.selectedQuote = res![index];
                        Navigator.of(context).pushNamed("details_page");
                      },
                      child: CarouselSlider(
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (val, _) {
                            index = val;
                          },
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          height: h * 0.25,
                          autoPlay: true,
                        ),
                        items: res?.map((e) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.hardLight,
                                ),
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                  e.image,
                                ),
                              ),
                            ),
                            width: w,
                            child: Text(
                              e.quot,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Global.button.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(e.path);
                      },
                      child: SizedBox(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: e.color,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              height: 60,
                              width: 60,
                              child:
                                  Icon(e.icon, color: Colors.white, size: 33),
                            ),
                            Text(
                              e.text,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Most Popular",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "motivational";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Motivational"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "love";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child:
                          customCategoryContainer(height: h, category: "Love"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "friendship";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Friendship"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "inspirational";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Inspirational"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Quotes by Category",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Global.isAuthorCategory = false;
                      Navigator.of(context).pushNamed("/quotes_by_category");
                    },
                    child: Text(
                      "View All >",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "sports";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Sports"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "wisdom";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Wisdom"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "life";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child:
                          customCategoryContainer(height: h, category: "Life"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.tableName = "business";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customCategoryContainer(
                          height: h, category: "Business"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Quotes by Author",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Global.isAuthorCategory = true;
                      Navigator.of(context).pushNamed("/quotes_by_category");
                    },
                    child: Text(
                      "View All >",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              //---------author-----------
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.isAuthor = true;
                        Global.tableName = "TedWilliams";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customAuthorContainer(
                          height: h, author: "TedWilliams"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.isAuthor = true;
                        Global.tableName = "dr_seuss";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child:
                          customAuthorContainer(height: h, author: "Dr Seuss"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.isAuthor = true;
                        Global.tableName = "albert_einstein";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customAuthorContainer(
                          height: h, author: "Albert\nEinstein"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Global.isAuthor = true;
                        Global.tableName = "elon_musk";
                        Navigator.of(context).pushNamed("/details_of_category");
                      },
                      child: customAuthorContainer(
                          height: h, author: "Elon\nMusk"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: drawer(context: context),
    );
  }
}
