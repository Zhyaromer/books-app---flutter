// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
part 'BookDetailResponse.g.dart';

@JsonSerializable()
class BookDetailResponse {
  final Book? book;
  final List<Series?>? series;
  final List<Boooks?>? seriesBooks;
  final List<Boooks?>? similarBooks;
  final List<Review?>? reviews;

  BookDetailResponse({
    this.book,
    this.series,
    this.seriesBooks,
    this.similarBooks,
    this.reviews,
  });

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BookDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookDetailResponseToJson(this);
}

@JsonSerializable()
class Book {
  final int? id;
  final String? title;
  final int? author_id;
  final int? series_id;
  final String? genre;
  final int? part_num;
  final String? language;
  final String? description;
  final String? published_date;
  final int? rating;
  final String? cover_image;
  final int? page_count;
  final int? views;
  final String? name;
  final String? bio;
  final String? imgURL;
  final String? quote;

  Book({
    this.id,
    this.title,
    this.author_id,
    this.series_id,
    this.genre,
    this.part_num,
    this.language,
    this.description,
    this.published_date,
    this.rating,
    this.cover_image,
    this.page_count,
    this.views,
    this.name,
    this.bio,
    this.imgURL,
    this.quote,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Series {
  final int? id;
  final String? series_title;
  final String? state;
  final String? cover_img;
  final String? description;

  Series({
    this.id,
    this.series_title,
    this.state,
    this.cover_img,
    this.description,
  });

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}

@JsonSerializable()
class Boooks {
  final int? id;
  final String? title;
  final int? author_id;
  final String? genre;
  final String? language;
  final int? page_count;
  final String? cover_image;
  final String? name;
  final String? imgURL;
  final int? part_num;

  Boooks({
    this.id,
    this.title,
    this.author_id,
    this.genre,
    this.language,
    this.page_count,
    this.cover_image,
    this.name,
    this.imgURL,
    this.part_num,
  });

  factory Boooks.fromJson(Map<String, dynamic> json) => _$BoooksFromJson(json);
  Map<String, dynamic> toJson() => _$BoooksToJson(this);
}

@JsonSerializable()
class Review {
  final int? id;
  final int? user_id;
  final int? book_id;
  final int? rating;
  final String? comment;
  final String? created_at;
  final int? isSpoiler;
  final String? title;
  final String? username;
  final String? coverImgURL;

  Review({
    this.id,
    this.user_id,
    this.book_id,
    this.rating,
    this.comment,
    this.created_at,
    this.isSpoiler,
    this.title,
    this.username,
    this.coverImgURL,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  get reviewerName => null;
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

Future<BookDetailResponse> fetchBookDetail(int bookId) async {
  final res = await Dio().get(
    'http://localhost:3000/books/getBookById/$bookId',
  );

  if (res.statusCode == 200) {
    return BookDetailResponse.fromJson(res.data);
  } else {
    throw Exception('Failed to load book details');
  }
}
