import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:book_app/views/widgets/book_card.dart';

class homepage extends StatelessWidget {
  const homepage({super.key, required this.collections});
  final List<Book> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = collections[index];

        return BookCard(
          title: book.name,
          author: book.authors,
          rating: book.votes,
          thumbnailUrl: book.cover,
          websiteUrl: book.url,
          bookId: book.bookID.toString(),
        );
      },
    );
  }
}
