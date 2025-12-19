// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Books _$BooksFromJson(Map<String, dynamic> json) => Books(
  title: json['title'] as String,
  author_id: (json['author_id'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  genre: json['genre'] as String,
  language: json['language'] as String,
  page_count: (json['page_count'] as num).toInt(),
  cover_image: json['cover_image'] as String,
  imgURL: json['imgURL'] as String,
);

Map<String, dynamic> _$BooksToJson(Books instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'name': instance.name,
  'author_id': instance.author_id,
  'genre': instance.genre,
  'language': instance.language,
  'page_count': instance.page_count,
  'cover_image': instance.cover_image,
  'imgURL': instance.imgURL,
};
