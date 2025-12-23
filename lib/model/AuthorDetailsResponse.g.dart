// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthorDetailsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDetailsResponse _$AuthorDetailsResponseFromJson(
  Map<String, dynamic> json,
) => AuthorDetailsResponse(
  author: (json['author'] as List<dynamic>?)
      ?.map(
        (e) => e == null ? null : Author.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  books: (json['books'] as List<dynamic>?)
      ?.map(
        (e) =>
            e == null ? null : AuthorBooks.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$AuthorDetailsResponseToJson(
  AuthorDetailsResponse instance,
) => <String, dynamic>{'author': instance.author, 'books': instance.books};

AuthorBooks _$AuthorBooksFromJson(Map<String, dynamic> json) => AuthorBooks(
  id: (json['id'] as num?)?.toInt(),
  coverImage: json['cover_image'] as String?,
);

Map<String, dynamic> _$AuthorBooksToJson(AuthorBooks instance) =>
    <String, dynamic>{'id': instance.id, 'cover_image': instance.coverImage};

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  imgURL: json['imgURL'] as String?,
  language: json['language'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'bio': instance.bio,
  'imgURL': instance.imgURL,
  'language': instance.language,
  'dateOfBirth': instance.dateOfBirth,
  'country': instance.country,
};
