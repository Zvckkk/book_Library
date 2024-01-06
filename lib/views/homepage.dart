import 'package:book_app/models/book.api.dart';
import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:book_app/views/widgets/book_card.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Book> collections = [];

  @override
  void initState() {
    super.initState();
    fetchTopBooks().then((books) {
      setState(() {
        collections = books;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = collections[index];

        return BookCard(
            title: book.name,
            author: book.author,
            rating: book.votes,
            thumbnailUrl: book.cover,
            websiteUrl: book.url,
            // launchUrl: launchUrl
          );
      },
    );
  }
}
