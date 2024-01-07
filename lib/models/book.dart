class Book {
  final String name;
  final String? authors;
  final num votes;
  final String cover;
  final String url;
  final int bookID;

  Book({
    required this.name,
    required this.authors,
    required this.cover,
    required this.votes,
    required this.url,
    required this.bookID,
  });
}
