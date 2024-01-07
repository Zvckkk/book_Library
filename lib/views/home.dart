import 'package:book_app/models/book.api.dart';
import 'package:flutter/material.dart';
import 'package:book_app/views/bookmark.dart';
import 'package:book_app/views/search.dart';
import 'package:book_app/views/homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    const homepage(
      collections: [],
    ),
    const BookmarkPage(),
    const search(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTopBooks().then((books) {
      setState(() {
        _pages = [
          homepage(
            collections: books,
          ),
          const BookmarkPage(),
          const search(),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined),
          SizedBox(width: 10.0),
          Text(
            'Book Library',
          )
        ],
      )),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
