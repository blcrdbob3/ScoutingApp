/*
homePage.dart, a page/screen to serve as a home screen to

Current issues with this file:
Fix orientation issues with dynamic sizing
Save a variable so that you don't have to log in every single time (after you've
clicked login)
*/

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/scoutingPage.dart';
import 'package:sizer/sizer.dart';

// HomePage, root class/function for creating the page

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // scaffold
    return Scaffold(
        // container
        body: Container(
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // title
                  Text("Team 178 Scouting Wizard",
                      style: TextStyle(
                        fontSize: 8.w,
                        fontWeight: FontWeight.bold,
                      )),
                  // scout button
                  ElevatedButton.icon(
                    label: Text("Scout", style: TextStyle(fontSize: 6.w)),
                    icon: Icon(Icons.auto_fix_high, size: 6.w),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: Colors.grey),
                      minimumSize: Size(32.w, 8.h),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ScoutingPage();
                        },
                      ));
                    },
                  ),
                  // sync button
                  ElevatedButton.icon(
                    label: Text("Sync", style: TextStyle(fontSize: 6.w)),
                    icon: Icon(Icons.all_inclusive, size: 6.w),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(32.w, 8.h),
                    ),
                    onPressed: () {
                      // what "snackbars" are like teeny tiny bars/notifications at the bottom
                      // used usually to tell the user that's something's happened/happening
                      // syncing data message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Syncing Data')),
                      );
                      // synced data message (add wait after computer says sync is complete)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Synced Data')),
                      );
                    },
                  )
                ])));
  }
}
