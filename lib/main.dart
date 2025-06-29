import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'staff_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFF6A1B9A); // Deep Purple
  final Color accentColor = Color(0xFFBA68C8);  // Lighter Purple

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff CRUD App',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          secondary: accentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
      ),
      home: StaffListPage(),
    );
  }
}
