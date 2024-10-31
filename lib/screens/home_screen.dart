import 'package:flutter/material.dart';
import 'book_list_screen.dart'; // นำเข้าหน้ารายการหนังสือ
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> user; // ประกาศตัวแปร user

  HomeScreen({super.key, required this.user}); // รับ user ผ่าน constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListScreen()),
                );
              },
              child: Text('View Available Books'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                        user: user), // ส่ง user ไปยัง ProfileScreen
                  ),
                );
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
//