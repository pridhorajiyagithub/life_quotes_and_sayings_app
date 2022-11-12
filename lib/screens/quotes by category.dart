import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life_quotes_and_sayings_app/global.dart';

class QuotesByCategory extends StatefulWidget {
  const QuotesByCategory({Key? key}) : super(key: key);

  @override
  State<QuotesByCategory> createState() => _QuotesByCategoryState();
}

class _QuotesByCategoryState extends State<QuotesByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          //"Quote by category",
          "Quotes By ${(Global.isAuthorCategory) ? "Author" : "Category"}",
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
      body: ListView.builder(
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    // Global.isAuthor = false;
                    // Global.tableName = Global.quoteCategory[i].name;
                    (Global.isAuthorCategory)
                        ? Global.isAuthor = true
                        : Global.isAuthor = false;
                    Global.tableName = (Global.isAuthorCategory)
                        ? Global.authorList[i].category
                        : Global.quoteCategory[i].category;
                    Navigator.of(context).pushNamed('/details_of_category');
                  },
                  title: Text(
                    (Global.isAuthorCategory)
                        ? Global.authorList[i].name
                        : Global.quoteCategory[i].name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]
                        .withOpacity(0.8),
                    child: Text((Global.isAuthorCategory)
                        ? Global.authorList[i].name.substring(0, 2)
                        : Global.quoteCategory[i].name.substring(0, 2)),
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: Colors.blueGrey.withOpacity(0.7),
                  // height: 1,
                  indent: 105,
                ),
              ],
            ),
          );
        },
        itemCount: (Global.isAuthorCategory)
            ? Global.authorList.length
            : Global.quoteCategory.length,
        // Global.quoteCategory.length,
      ),
    );
  }
}
