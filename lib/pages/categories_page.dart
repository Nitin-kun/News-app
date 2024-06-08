import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/widgets/button.dart';
import '../auth/login_screen.dart';
import 'home_screen.dart';

import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(58.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomButton(
              label: "Sports",
              onPressed: () {
                goToHome(context, "sports");
              },
            ),
            SizedBox(height: 25),
            CustomButton(
              label: "Entertainment",
              onPressed: () {
                goToHome(context, "entertainment");
              },
            ),
            SizedBox(height: 25),
            CustomButton(
              label: "Technology",
              onPressed: () {
                goToHome(context, "technology");
              },
            ),
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  void goToHome(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(category: category),
      ),
    );
  }
}
