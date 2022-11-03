/*
main.dart, a file used to run and build the scouting app
*/

// imports that locate and use files in the app, such as packages (look at packages.md) or files in the project
// NOTE: for package:scoutingapp, it will start at scoutingapp/lib/.

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoutingapp/screens/loginPage.dart';
import 'package:sizer/sizer.dart';

// function to start the app

void main() {
  runApp(const SampleApp());
}

// create list of MaterialColors for custom theme

Map<int, Color> colorCodes = {
  50: const Color.fromRGBO(15, 8, 56, .1),
  100: const Color.fromRGBO(15, 8, 56, .2),
  200: const Color.fromRGBO(15, 8, 56, .3),
  300: const Color.fromRGBO(15, 8, 56, .4),
  400: const Color.fromRGBO(15, 8, 56, .5),
  500: const Color.fromRGBO(15, 8, 56, .6),
  600: const Color.fromRGBO(15, 8, 56, .7),
  700: const Color.fromRGBO(15, 8, 56, .8),
  800: const Color.fromRGBO(15, 8, 56, .9),
  900: const Color.fromRGBO(15, 8, 56, 1),
};

MaterialColor customColor = MaterialColor(0xFF0F0838, colorCodes);

// root class/function for building the app

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  // line above is unnecessary, but I'll explain why it's there
  // since flutter is a declarative language, it wants everything to be constant for null safety, so this makes the function constant.

  @override
  Widget build(BuildContext context) {
    // sizer is a package that changes the size of widgets depending on screen size/orientation
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false, // turns off debug banner
          title: 'ScoutingWizard', // title of the app
          theme: ThemeData(primarySwatch: customColor), // custom theme
          home: AnimatedSplashScreen(
              // splash screen, just a cool little animation for when app starts
              splash: Icons.hourglass_bottom_rounded, // icon for splash screen
              nextScreen: const LoginPage(), // screen to switch to after
              splashTransition: SplashTransition
                  .slideTransition, // transition type of splash screen
              pageTransitionType: PageTransitionType
                  .bottomToTop // transition type when switching page
              ));
    });
  }
}
