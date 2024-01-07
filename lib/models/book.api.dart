import 'dart:convert';
import 'package:http/http.dart';

import 'book.dart';

Future<List<Book>> fetchData(String name) async {
  print("searching: $name");
  List<Book> bookCollection = [];
  Uri url = Uri.https('hapi-books.p.rapidapi.com', '/search/$name');
  Response res = await get(url, headers: {
    'X-RapidAPI-Key': 'c295f668edmsh838a86c288e53dcp1ab633jsn5c7306b3eab3',
    'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
  });

  print(res.statusCode);
  if (res.statusCode == 200) {
    final data = json.decode(res.body);

    for (var book in data) {
      print(book);
      bookCollection.add(Book(
          name: book["name"],
          authors: book["authors"][0],
          cover: book["cover"],
          votes: book["rating"],
          url: book["url"],
          bookID: book['book_id']));
    }
  }

  return bookCollection;
}

Future<List<Book>> fetchTopBooks() async {
  List<Book> bookCollection = [];
  DateTime now = DateTime.now();
  int year = now.year;
  int month = now.month;
  Uri url = Uri.https('hapi-books.p.rapidapi.com', '/month/$year/$month');
  Response res = await get(url, headers: {
    'X-RapidAPI-Key': 'c295f668edmsh838a86c288e53dcp1ab633jsn5c7306b3eab3',
    'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
  });

  print(res.statusCode);

  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    print(data);
    for (var book in data) {
      print(book);
      bookCollection.add(Book(
          name: book["name"],
          authors: book["author"],
          cover: book["cover"],
          votes: book["rating"],
          url: book["url"],
          bookID: int.parse(book["book_id"])));
    }
  }

  return bookCollection;
}
