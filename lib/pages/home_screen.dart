import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

import 'categories_page.dart';

class HomeScreen extends StatefulWidget {
  final String category;

  HomeScreen({required this.category});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference dbref = FirebaseDatabase.instance.ref("/categories");
  List<Map<String, dynamic>> categoryData = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    try {
      DataSnapshot snapshot = await dbref.child(widget.category).get();

      if (snapshot.exists) {
        List<dynamic> dataList = snapshot.value as List<dynamic>;
        List<Map<String, dynamic>> data = dataList.map((item) {
          if (item is Map<String, dynamic>) {
            return item;
          } else if (item is Map<Object?, Object?>) {
            // Convert keys to strings
            return item.map((key, value) => MapEntry(key.toString(), value));
          } else {
            // Handle other types or null values
            return <String, dynamic>{};
          }
        }).toList();

        setState(() {
          categoryData = data;
        });

        print('Fetched data: $categoryData');
      } else {
        print('No data available.');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: categoryData.length,
        itemBuilder: (context, index) {
          final item = categoryData[index];
          return GestureDetector(
            onHorizontalDragUpdate: (dragDetail) {
              if (dragDetail.delta.dx < 0) {
                launchUrl(Uri.parse(item['url']),
                    mode: LaunchMode.inAppWebView);
                print(item.keys);
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoriesPage()));
              }
            },
            child: Container(
              padding: const EdgeInsets.only(
                  top: 32, left: 24, right: 24, bottom: 12),
              child: Column(
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  item['images'] != null
                      ? Image.network(
                          item['images'],
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),
                  Text(
                    item['description'] ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _launchURL(String? link) async {
    if (await canLaunchUrl(link! as Uri)) {
      await launchUrl(link as Uri);
    } else {
      throw 'Could not launch $link';
    }
  }
}
