import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tu_pension/central.dart';
import 'package:tu_pension/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tu_pension/ui/controllers/authentication_controller.dart';
import 'package:tu_pension/ui/controllers/user_controller.dart';

import 'package:tu_pension/routes.dart';
import 'package:tu_pension/theme.dart';
import 'package:tu_pension/ui/screens/home/home_screen.dart';
import 'package:tu_pension/ui/screens/sign_in/sign_in_screen.dart';
import 'package:tu_pension/ui/screens/splash/splash_screen.dart';

void main() {
  // Get.put(AuthenticationController());
  // Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Future<String> _isUserLoggedIn() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    print(user);
    if (user == null) {
      print('User is currently signed out!');
      return SplashScreen.routeName;
    } else {
      // User is signed in
      print('User is signed in!');
      return HomeScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(AuthenticationController());
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Flutter Way - Template',
              theme: AppTheme.lightTheme(context),
              // initialRoute: SplashScreen.routeName,
              home: FutureBuilder(
                future: _isUserLoggedIn(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the future
                    return const CircularProgressIndicator();
                  } else {
                    // Return the appropriate route based on the result of _isUserLoggedIn
                    String initialRoute =
                        snapshot.data ?? SignInScreen.routeName;

                    // Use Navigator to navigate to the determined initialRoute
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacementNamed(initialRoute);
                    });

                    // Return an empty container, as we are using Navigator for navigation
                    return Container();
                  }
                },
              ),
              routes: routes,
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Scaffold(
            body: Center(
              child: Text('Loading'),
            ),
          );
        });
  }
}
