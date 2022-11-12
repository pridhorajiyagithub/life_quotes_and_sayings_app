import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'model/category.dart';
import 'model/drower.dart';
import 'model/icon button.dart';
import 'model/quot.dart';

class Global {
  static List<DrawerData1> drawerData1 = [
    DrawerData1(
        icon: Icons.topic_outlined,
        iconName: "By Topic",
        color: Colors.deepOrange),
    DrawerData1(icon: Icons.person, iconName: "By Author", color: Colors.blue),
    DrawerData1(icon: Icons.star, iconName: "Favourite", color: Colors.amber),
    DrawerData1(
        icon: Icons.lightbulb,
        iconName: "Quote of the Day",
        color: Colors.orangeAccent),
    DrawerData1(
        icon: Icons.image, iconName: "Favourite Pictures", color: Colors.amber),
    DrawerData1(
        icon: Icons.video_collection, iconName: "Videos", color: Colors.red),
  ];

  static List<DrawerData2> drawerData2 = [
    DrawerData2(icon: Icons.settings, iconName: "Settings"),
    DrawerData2(icon: Icons.share_outlined, iconName: "Share"),
    DrawerData2(icon: Icons.play_arrow, iconName: "Rate"),
    DrawerData2(icon: Icons.mail, iconName: "Feedback"),
    DrawerData2(icon: Icons.search, iconName: "Our other apps"),
    DrawerData2(icon: Icons.info_outline, iconName: "About"),
  ];
  static List<Button> button = [
    Button(
      text: 'Categories',
      path: '/quotes_by_category',
      color: const Color(0xffA45584),
      icon: Icons.grid_view,
    ),
    Button(
      text: 'Pic Quotes',
      path: '/popular_quotes',
      color: const Color(0xff7589C8),
      icon: Icons.image_outlined,
    ),
    Button(
      text: 'Latest',
      path: '/latest_quotes',
      color: const Color(0xffB99041),
      icon: Icons.sunny,
    ),
    Button(
        text: 'Articles',
        path: '/articles',
        color: const Color(0xff6C9978),
        icon: Icons.menu_book_sharp)
  ];

  static String tableName = "";
  static DBQuot? selectedQuote;
  static bool isAuthor = false;
  static ScreenshotController screenshotController = ScreenshotController();
  static bool isAuthorCategory = false;

  static List<Category> quoteCategory = [
    // Category(category: "ability", name: "Ability"),
    // Category(category: "competition", name: "Competition"),
    // Category(category: "Latest", name: "Famous Quotes"),
    // Category(category: "friendship", name: "Friendship"),
    // Category(category: "future", name: "Future"),
    // Category(category: "inspirational", name: "Inspirational"),
    // Category(category: "life", name: "Life"),
    // Category(category: "love", name: "Love"),
    // Category(category: "motivational", name: "Motivational"),
    // Category(category: "sports", name: "Sports"),
    // Category(category: "wisdom", name: "Wisdom"),
    Category(category: "friendship", name: "Friendship"),
    Category(category: "competition", name: "Competition"),
    Category(category: "Famous Quotes", name: "Latest"),
    Category(category: "life", name: "Life"),
    Category(category: "future", name: "Future"),
    Category(category: "business", name: "Business"),
    Category(category: "inspirational", name: "Inspirational"),
    // Category(name: "anger", category: "Anger"),
    Category(category: "love", name: "Love"),
    Category(category: "motivational", name: "Motivational"),
    Category(category: "sports", name: "Sports"),
    Category(category: "wisdom", name: "Wisdom"),
  ];

  static List<Category> authorList = [
    Category(category: "MichaelJordan", name: "MichaelJordan"),
    Category(category: "MuhammadAli", name: "MuhammadAli"),
    Category(category: "DesmondTutu", name: "DesmondTutu"),
    Category(category: "chanakya", name: "Chanakya"),
    Category(category: "dr_seuss", name: "Dr Seuss"),
    Category(category: "elon_musk", name: "Elon Musk"),
    Category(category: "robert_griffin_iii", name: "Robert Griffin Iii"),
    Category(category: "donald_trump", name: "Donald Trump"),
    Category(category: "albert_einstein", name: "Albert Einstein"),
    Category(category: "AnnaPavlova", name: "AnnaPavlova"),
    Category(category: "TedWilliams", name: "TedWilliams"),
  ];
}
