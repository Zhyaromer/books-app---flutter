// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDetailResponse _$BookDetailResponseFromJson(Map<String, dynamic> json) =>
    BookDetailResponse(
      book: json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
      series: (json['series'] as List<dynamic>?)
          ?.map(
            (e) =>
                e == null ? null : Series.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      seriesBooks: (json['seriesBooks'] as List<dynamic>?)
          ?.map(
            (e) =>
                e == null ? null : Boooks.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      similarBooks: (json['similarBooks'] as List<dynamic>?)
          ?.map(
            (e) =>
                e == null ? null : Boooks.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map(
            (e) =>
                e == null ? null : Review.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$BookDetailResponseToJson(BookDetailResponse instance) =>
    <String, dynamic>{
      'book': instance.book,
      'series': instance.series,
      'seriesBooks': instance.seriesBooks,
      'similarBooks': instance.similarBooks,
      'reviews': instance.reviews,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  author_id: (json['author_id'] as num?)?.toInt(),
  series_id: (json['series_id'] as num?)?.toInt(),
  genre: json['genre'] as String?,
  part_num: (json['part_num'] as num?)?.toInt(),
  language: json['language'] as String?,
  description: json['description'] as String?,
  published_date: json['published_date'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  cover_image: json['cover_image'] as String?,
  page_count: (json['page_count'] as num?)?.toInt(),
  views: (json['views'] as num?)?.toInt(),
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  imgURL: json['imgURL'] as String?,
  quote: json['quote'] as String?,
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author_id': instance.author_id,
  'series_id': instance.series_id,
  'genre': instance.genre,
  'part_num': instance.part_num,
  'language': instance.language,
  'description': instance.description,
  'published_date': instance.published_date,
  'rating': instance.rating,
  'cover_image': instance.cover_image,
  'page_count': instance.page_count,
  'views': instance.views,
  'name': instance.name,
  'bio': instance.bio,
  'imgURL': instance.imgURL,
  'quote': instance.quote,
};

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
  id: (json['id'] as num?)?.toInt(),
  series_title: json['series_title'] as String?,
  state: json['state'] as String?,
  cover_img: json['cover_img'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
  'id': instance.id,
  'series_title': instance.series_title,
  'state': instance.state,
  'cover_img': instance.cover_img,
  'description': instance.description,
};

Boooks _$BoooksFromJson(Map<String, dynamic> json) => Boooks(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  author_id: (json['author_id'] as num?)?.toInt(),
  genre: json['genre'] as String?,
  language: json['language'] as String?,
  page_count: (json['page_count'] as num?)?.toInt(),
  cover_image: json['cover_image'] as String?,
  name: json['name'] as String?,
  imgURL: json['imgURL'] as String?,
  part_num: (json['part_num'] as num?)?.toInt(),
);

Map<String, dynamic> _$BoooksToJson(Boooks instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author_id': instance.author_id,
  'genre': instance.genre,
  'language': instance.language,
  'page_count': instance.page_count,
  'cover_image': instance.cover_image,
  'name': instance.name,
  'imgURL': instance.imgURL,
  'part_num': instance.part_num,
};

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: (json['id'] as num?)?.toInt(),
  user_id: (json['user_id'] as num?)?.toInt(),
  book_id: (json['book_id'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toInt(),
  comment: json['comment'] as String?,
  created_at: json['created_at'] as String?,
  isSpoiler: (json['isSpoiler'] as num?)?.toInt(),
  title: json['title'] as String?,
  username: json['username'] as String?,
  coverImgURL: json['coverImgURL'] as String?,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'book_id': instance.book_id,
  'rating': instance.rating,
  'comment': instance.comment,
  'created_at': instance.created_at,
  'isSpoiler': instance.isSpoiler,
  'title': instance.title,
  'username': instance.username,
  'coverImgURL': instance.coverImgURL,
};
