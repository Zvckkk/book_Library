import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class BookCard extends StatefulWidget {
  final String title;
  final num rating;
  final String? author;
  final String thumbnailUrl;
  final String websiteUrl;
  final String bookId;
  final VoidCallback? onBookmark;

  const BookCard(
      {Key? key,
      required this.title,
      required this.author,
      required this.rating,
      required this.thumbnailUrl,
      required this.websiteUrl,
      required this.bookId,
      this.onBookmark})
      : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool bookmarked = false;

  @override
  void initState() {
    super.initState();
    checkBookmarked();
  }

  void checkBookmarked() async {
    print('check bookmarks');
    final prefs = await SharedPreferences.getInstance();
    String bookmarkData = prefs.getString('bookmarks') ?? "{}";
    Map<String, dynamic> bookmarks = jsonDecode(bookmarkData);

    setState(() {
      bookmarked = bookmarks[widget.bookId] != null;
    });
  }

  Future<void> _saveToBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("testing");
    print(prefs.getString('bookmarks'));
    String bookmarkData = prefs.getString('bookmarks') ?? "{}";
    Map<String, dynamic> bookmarks = jsonDecode(bookmarkData);

    if (bookmarks[widget.bookId] == null) {
      bookmarks[widget.bookId] = {
        'name': widget.title,
        'author': widget.author,
        'cover': widget.thumbnailUrl,
        'votes': widget.rating,
        'url': widget.websiteUrl,
        'book_id': widget.bookId
      };
    } else {
      bookmarks.remove(widget.bookId);
    }

    prefs.setString('bookmarks', jsonEncode(bookmarks));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(widget.thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 19,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(widget.rating.toString()),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(widget.author ?? "no author"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse(widget.websiteUrl));
              },
              child: const Text('Visit BookStore'),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              onPressed: () async {
                await _saveToBookmarks();
                checkBookmarked();
                final onBookmark = widget.onBookmark;
                if (onBookmark != null) onBookmark();
              },
              child: Icon(
                Icons.bookmark,
                color: bookmarked ? Colors.blue : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
