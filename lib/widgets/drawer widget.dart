import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';

drawer({required BuildContext context}) {
  return SafeArea(
    child: Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text(
                "Life Quotes and\nsaying",
                style: GoogleFonts.pacifico(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: Global.drawerData1
                  .map(
                    (e) => ListTile(
                      onTap: () {},
                      leading: Icon(
                        e.icon,
                        color: e.color,
                        size: 22,
                      ),
                      title: Text(
                        e.iconName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Divider(color: Colors.blueGrey.withOpacity(0.3), thickness: 1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              width: double.infinity,
              child: Text(
                "Communicate",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff666666).withOpacity(0.7),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Column(
              children: Global.drawerData2
                  .map(
                    (e) => ListTile(
                      onTap: () {},
                      leading: Icon(
                        e.icon,
                        size: 22,
                      ),
                      title: Text(
                        e.iconName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
