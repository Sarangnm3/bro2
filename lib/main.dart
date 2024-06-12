import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'home_page.dart';
import 'login.dart';

const White = Color(0xfffbe6bf);
const Orange = Color(0xffd64612);
const Dark = Color(0xff1e2b33);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BroCar());
}

class BroCar extends StatefulWidget {
  const BroCar({super.key});

  @override
  _CarSalesAppState createState() => _CarSalesAppState();
}

class _CarSalesAppState extends State<BroCar> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    var currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      isLogin = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bro Car app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Dark,
        scaffoldBackgroundColor: Dark,
        hintColor: Orange,
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? const HomePage() : const Login(),
    );
  }
}
