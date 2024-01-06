import 'package:book_app/models/book.api.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/views/widgets/book_card.dart';
import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String searchKey = "";
  List<Book> books = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = searchKey;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onSubmitted: (_) async {
              final bookCollections = await fetchData(searchKey);
              setState(() {
                books = bookCollections;
              });
            },
            onChanged: (value) {
              setState(() {
                searchKey = value;
              });
            },
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 0.8),
              ),
              hintText: 'What book do you want to Read?',
              prefixIcon: const Icon(
                Icons.search,
                size: 30.0,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              ),
            ),
          ),
        ),

        // list view
        Flexible(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return BookCard(
                    title: book.name,
                    author: book.author,
                    rating: book.votes,
                    thumbnailUrl: book.cover,
                    websiteUrl: book.url);
              }),
        )
      ],
    ));
  }
}
