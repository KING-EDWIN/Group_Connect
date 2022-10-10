import 'package:flutter/material.dart';
import 'package:Group_Connect/Screens/Welcome/welcome_screen.dart';
import 'package:Group_Connect/constants.dart';

import 'package:Group_Connect/Home/mainNav.dart';
import 'package:flutter/material.dart';

import 'screens/SCREENS/auth.dart';
import 'screens/SCREENS/feed.dart';
import 'screens/SCREENS/courseHome.dart';
import 'screens/SCREENS/addPostInCourse.dart';
import 'screens/SCREENS/createCourse.dart';
import 'screens/SCREENS/enrolledCourse.dart';
import 'screens/SCREENS/userHome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/Auth.dart';
import 'providers/Course.dart';
import 'providers/coursePost.dart';
import 'screens/SCREENS/loading.dart';
import 'screens/SCREENS/courseDetail.dart';
import 'package:Group_Connect/Home/mainNav.dart';
import 'package:Group_Connect/Home/courseNav.dart';
import 'package:Group_Connect/screens/SCREENS/coursePostDetail.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group Connect',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}

//THIS IS TRIAL
void mains() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApps extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, CourseProvider>(
          create: null,
          update: (ctx, UserProvider, previous) =>
              CourseProvider(userProfile: UserProvider.userProfile),
        ),
        ChangeNotifierProxyProvider<UserProvider, CoursePostProvider>(
          create: null,
          update: (ctx, UserProvider, previous) =>
              CoursePostProvider(userProfile: UserProvider.userProfile),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepPurpleAccent,
        ),
        home: Loading(),
        routes: {
          Loading.routeName: (ctx) => Loading(),
          Auth.routeName: (ctx) => Auth(),
          CourseDetail.routeName: (ctx) => CourseDetail(),
          CreateCourse.routeName: (ctx) => CreateCourse(),
          AddPostCourse.routeName: (ctx) => CreateCourse(),
          MainNav.routeName: (ctx) => MainNav(),
          CourseNav.routeName: (ctx) => CourseNav(),
          Feed.routeName: (ctx) => CourseNav(),
          UserHomeFeed.routeName: (ctx) => CourseNav(),
          EnrolledCourse.routeName: (ctx) => CourseNav(),
        },
      ),
    );
  }
}