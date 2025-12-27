// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SeriesDetailsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDetailsResponse _$SeriesDetailsResponseFromJson(
  Map<String, dynamic> json,
) => SeriesDetailsResponse(
  id: (json['id'] as num?)?.toInt(),
  series_title: json['series_title'] as String?,
  cover_img: json['cover_img'] as String?,
  state: json['state'] as String?,
  description: json['description'] as String?,
  books: (json['books'] as List<dynamic>?)
      ?.map((e) => BooksInSeries.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SeriesDetailsResponseToJson(
  SeriesDetailsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'series_title': instance.series_title,
  'cover_img': instance.cover_img,
  'state': instance.state,
  'description': instance.description,
  'books': instance.books,
};

BooksInSeries _$BooksInSeriesFromJson(Map<String, dynamic> json) =>
    BooksInSeries(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      cover_image: json['cover_image'] as String?,
      published_date: json['published_date'] as String?,
      genre: json['genre'] as String?,
      description: json['description'] as String?,
      page_count: (json['page_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BooksInSeriesToJson(BooksInSeries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover_image': instance.cover_image,
      'published_date': instance.published_date,
      'genre': instance.genre,
      'description': instance.description,
      'page_count': instance.page_count,
    };
