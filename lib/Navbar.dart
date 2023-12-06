//import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'APP OWNER:  W.M. Seshan Nethmika ',
              style: GoogleFonts.oswald(color: Colors.black),
            ),
            accountEmail: Text(
              'Email:  seshan.nethmika@gmail.com',
              style: GoogleFonts.oswald(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/home1.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              'Favorites',
              style: GoogleFonts.oswald(),
            ),
            onTap: () {
                  Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              'Share',
              style: GoogleFonts.oswald(),
            ),
            onTap: () {
              Share.share("SN creations in sri lanka.");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: GoogleFonts.oswald(),
            ),
            onTap: () {
              Share.share(
                  "Authorised app by SN creations to calculate BMI rate.\nowner by seshan nethmika.");
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(
              'Policies',
              style: GoogleFonts.oswald(),
            ),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: SizedBox(
          //     height: 34,
          //     child: Image.asset('assets/exit.gif'),
          //   ),
          //   title: Text('Exit',
          //   style: GoogleFonts.oswald(),),

          // title: Text('Exit'),
          // leading: Icon(Icons.exit_to_app),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Exit',
              style: GoogleFonts.oswald(),
            ),
            onTap: () async {
              final value = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Do you want to exit?',
                        style: GoogleFonts.oswald(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              'No',
                              style: GoogleFonts.oswald(),
                            )),
                        TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: Text(
                              'Exit',
                              style: GoogleFonts.oswald(),
                            )),
                      ],
                    );
                  });
              if (value != null) {
                return Future.value(value);
              } else {
                return Future.value(false);
              }
            },

            //     onPressed: () {
            //   if (Platform.isAndroid) {
            //     SystemNavigator.pop();
            //   } else if (Platform.isIOS) {
            //     exit(0);
            //   }
            // },
          ),
        ],
      ),
    );
  }
}
