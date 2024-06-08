import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../auth/login_screen.dart';
import 'categories_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5, // Number of pages
        itemBuilder: (context, index) {
          return GestureDetector(
            onHorizontalDragEnd: (dragDetail) {
              if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
                print(" site");
              } else {
                print("categories");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              }
            },
            child: Container(
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Page $index',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
}
