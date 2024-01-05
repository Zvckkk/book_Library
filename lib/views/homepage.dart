import 'package:flutter/material.dart';
import 'package:book_app/views/widgets/book_card.dart';
import 'package:url_launcher/url_launcher.dart';
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BookCard(title: 'title',
          author: 'author',
          rating: 'votes',
          thumbnailUrl: 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588843906l/52861201._SY475_.jpg',
          websiteUrl: 'https://www.goodreads.com/book/show/52861201-from-blood-and-ash?from_choice=true',
          launchUrl: launchUrl,)
      ],
    );
  }
}

