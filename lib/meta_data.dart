import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class MetaData {
  Future<void> Fetchdata() async {
    DatabaseReference dbref = FirebaseDatabase.instance.ref("/categories");

    try {
      // Fetching data from the database
      DataSnapshot snapshot = await dbref.get();

      if (snapshot.exists) {
        // If data exists, print it
        print('Data: ${snapshot.value}');
      } else {
        print('No data available.');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }
}
