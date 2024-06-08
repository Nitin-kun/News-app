import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryData.length,
              itemBuilder: (context, index) {
                final item = categoryData[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      // Handle item tap
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['description'] ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          item['images'] != null
                              ? Image.network(
                                  item['images'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(), // Add SizedBox if images are null
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
