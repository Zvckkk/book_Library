import 'package:book_app/models/book.api.dart';
import 'package:book_app/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LibraryPage());
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryState();
}

class _LibraryState extends State<LibraryPage> {
  String name = 'The Binding Room';

  @override
  void initState() {
    super.initState();

    // fetchData(name);
    print("working");
    fetchTopBooks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
