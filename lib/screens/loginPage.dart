/*
loginPage.dart, a page/screen to serve as an intro/login

Clarification for those who do not know:
A widget is an object that you can see while using the app, the user
interface. Anything you see in the user interface is a widget.

w and h is a variable from sizer that either represents the width or height in percentage
of the screen. You'll be using these variables a lot, because dynamic sizing can get
really complicated!

Current issues with this file:
Fix orientation issues with dynamic sizing
*/

import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/homePage.dart';
import 'package:sizer/sizer.dart';

// LoginPage, root class/function for creating the page

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // container is well, what the name implies, a container for widgets
        alignment: Alignment.center,
        // alignment helps align widgets, alignment.center keeps everything in the middle
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // these two lines help align as well
          // crossAxisAlignment aligns on the y-axis
          // mainAxisAlignment aligns on the x-axis
          children: <Widget>[
            // title
            Text("Scouting Wizard",
                style: TextStyle(
                  fontSize: 12.w,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )),
            // padding (creates spacing between widgets)
            SizedBox(height: 2.h),
            // subtitle
            Text("A scouting app for Team 178",
                style: TextStyle(
                  fontSize: 6.w,
                  color: Colors.grey[700],
                )),
            // padding (creates spacing between widgets)
            SizedBox(height: 4.h),
            // login button
            ElevatedButton.icon(
              label: Text("Login", style: TextStyle(fontSize: 6.w)),
              icon: Icon(Icons.account_circle, size: 6.w),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(width: 1, color: Colors.grey),
                minimumSize: Size(32.w, 8.h),
              ),
              onPressed: () {
                // Navigator is a function that transitions to another page/screen
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
