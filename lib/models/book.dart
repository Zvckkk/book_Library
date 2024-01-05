
class Book{
  final String name;
  final String author;
  final int votes;
  final String cover;

  Book({required this.name, required this.author, required this.cover, required this.votes});

  factory Book.fromJson(dynamic json) {
    return Book(
      name: json['name'] as String,
      author: json['author'] as String,
      votes: json['votes'] as int,
      cover: json['cover'] as String,
    );
  }


}