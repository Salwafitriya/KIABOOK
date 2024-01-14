import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:tubes_posyandu/features/app/splash_screen/splash_screen.dart';
import 'package:tubes_posyandu/features/pencatatan_bumil.dart';
import 'package:tubes_posyandu/features/pencatatan_list.dart';
import 'package:tubes_posyandu/features/pendaftaran_bumil.dart';
import 'package:tubes_posyandu/features/progress_bumil.dart';
import 'package:tubes_posyandu/features/user_auth/presentation/pages/login_page.dart';
import 'package:tubes_posyandu/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:tubes_posyandu/features/home_screen.dart';
import 'package:tubes_posyandu/features/pendaftaran_balita.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_posyandu/features/pencatatan_balita.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBPGGkapS3KBQzwRNcGVJsCSEw80kSVmCw',
        appId: '1:102643668285:android:8833061321abf2667a6154',
        messagingSenderId: '102643668285',
        projectId: 'posyandu-d3111',
        storageBucket: 'posyandu-d3111.appspot.com',
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomeScreen(),
        '/Pendaftaran': (context) => Pendaftaran(),
        '/Pencatatan': (context) => Pencatatan(),
        // '/ProgressBalita': (context) => PencatatanList(),
        '/PendaftaranIbuHamil': (context) => PendaftaranIbuHamil(),
        '/PencatatanIbuHamil': (context) => PencatatanIbuHamil(),
        '/PencatatanList': (Context) => PencatatanList(),
        '/ProgressIbuHamil': (Context) => ProgressIbuHamil(),
      },
    );
  }
}
