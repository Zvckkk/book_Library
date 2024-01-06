import 'dart:convert';
import 'package:http/http.dart';

import 'book.dart';

Future<List<Book>> fetchData(String name) async {
  List<Book> bookCollection = [];
  Uri url = Uri.https('hapi-books.p.rapidapi.com', '/search/$name');
  Response res = await get(url, headers: {
    'X-RapidAPI-Key': 'e6c05627c1msh69ce074e49c9534p1102e4jsnb15f6bc2dcaf',
    'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
  });

  if (res.statusCode == 200) {
    final data = json.decode(res.body);

    for (var book in data) {
      print(book);
      bookCollection.add(Book(
          name: book["name"],
          author: book["author"],
          cover: book["cover"],
          votes: book["rating"],
          url: book["url"]));
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
    'X-RapidAPI-Key': 'e6c05627c1msh69ce074e49c9534p1102e4jsnb15f6bc2dcaf',
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
          author: book["author"],
          cover: book["cover"],
          votes: book["rating"],
          url: book["url"]));
    }
  }

  return bookCollection;
}
