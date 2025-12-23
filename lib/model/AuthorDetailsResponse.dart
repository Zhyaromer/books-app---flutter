import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'AuthorDetailsResponse.g.dart';

@JsonSerializable()
class AuthorDetailsResponse {
  final List<Author?>? author;
  final List<AuthorBooks?>? books;

  AuthorDetailsResponse({this.author, this.books});

  factory AuthorDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailsResponseToJson(this);
}

@JsonSerializable()
class AuthorBooks {
  final int? id;

  @JsonKey(name: 'cover_image')
  final String? coverImage;

  AuthorBooks({this.id, this.coverImage});

  factory AuthorBooks.fromJson(Map<String, dynamic> json) =>
      _$AuthorBooksFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorBooksToJson(this);
}

@JsonSerializable()
class Author {
  final int? id;
  final String? name;
  final String? bio;
  final String? imgURL;
  final String? language;
  final String? dateOfBirth;
  final String? country;

  Author({
    this.id,
    this.name,
    this.bio,
    this.imgURL,
    this.language,
    this.dateOfBirth,
    this.country,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

Future<AuthorDetailsResponse> fetchAuthorDetail(int authorId) async {
  final res = await Dio().get(
    'http://localhost:3000/authors/getAuthorById/$authorId',
  );

  if (res.statusCode == 200) {
    return AuthorDetailsResponse.fromJson(res.data);
  } else {
    throw Exception('Failed to load author details');
  }
}
