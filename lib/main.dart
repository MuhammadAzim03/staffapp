import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'staff_list_page.dart'; // create this file later
import 'staff_creation_page.dart'; // create this file later

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff CRUD App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StaffListPage(), // Start with Staff List Page
    );
  }
}
