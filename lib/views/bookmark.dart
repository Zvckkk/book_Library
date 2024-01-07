import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/views/widgets/book_card.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Map<String, dynamic>> bookmarkedBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the bookmarks stored as JSON strings
    Map<String, dynamic> bookmarkJsons =
        jsonDecode(prefs.getString('bookmarks') ?? "{}");

    // Convert each JSON string to a map and add to the list
    bookmarkedBooks = bookmarkJsons.values
        .map((values) => values as Map<String, dynamic>)
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Page'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedBooks.length,
        itemBuilder: (context, index) {
          // Use the BookCard widget directly in the BookmarkPage
          return BookCard(
            title: bookmarkedBooks[index]['name'],
            author: bookmarkedBooks[index]['author'],
            rating: bookmarkedBooks[index]['votes'],
            thumbnailUrl: bookmarkedBooks[index]['cover'],
            websiteUrl: bookmarkedBooks[index]['url'],
            bookId: bookmarkedBooks[index]['book_id'],
            onBookmark: () {
              _loadBookmarks();
            },
          );
        },
      ),
    );
  }
}
