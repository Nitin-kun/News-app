import 'package:flutter/material.dart';
import 'package:news_app/widgets/button.dart';
import '../auth/login_screen.dart';
import 'home_screen.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (dragdetail) {
          if (dragdetail.delta.dx < 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(category: 'sports')));
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50], // Light background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                label: "Sports",
                onPressed: () {
                  goToHome(context, "sports");
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                label: "Entertainment",
                onPressed: () {
                  goToHome(context, "entertainment");
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                label: "Technology",
                onPressed: () {
                  goToHome(context, "technology");
                },
              ),
            ],
          ),
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
