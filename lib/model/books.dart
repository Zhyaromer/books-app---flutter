import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
part 'books.g.dart';

@JsonSerializable()
class Books {
  final int id;
  final String title;
  final String name;
  final int author_id;
  final String genre;
  final String language;
  final int page_count;
  final String cover_image;
  final String imgURL;

  Books({
    required this.title,
    required this.author_id,
    required this.id,
    required this.name,
    required this.genre,
    required this.language,
    required this.page_count,
    required this.cover_image,
    required this.imgURL,
  });

  factory Books.fromJson(Map<String, dynamic> json) => _$BooksFromJson(json);
  Map<String, dynamic> toJson() => _$BooksToJson(this);
}

Future<List<Books>> fetchBooks() async {
  final res = await Dio().get('http://localhost:3000/books/getAllBooks');

  if (res.statusCode == 200) {
    final List data = res.data['books'];
    return data.map((e) => Books.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load books');
  }
}
