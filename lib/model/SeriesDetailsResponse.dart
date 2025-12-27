import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
part 'SeriesDetailsResponse.g.dart';

@JsonSerializable()
class SeriesDetailsResponse {
  final int? id;
  final String? series_title;
  final String? cover_img;
  final String? state;
  final String? description;
  final List<BooksInSeries>? books;

  SeriesDetailsResponse({
    this.id,
    this.series_title,
    this.cover_img,
    this.state,
    this.description,
    this.books,
  });

  factory SeriesDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesDetailsResponseToJson(this);
}

@JsonSerializable()
class BooksInSeries {
  final int? id;
  final String? title;
  final String? cover_image;
  final String? published_date;
  final String? genre;
  final String? description;
  final int page_count;

  BooksInSeries({
    this.id,
    this.title,
    this.cover_image,
    this.published_date,
    this.genre,
    this.description,
    this.page_count = 0,
  });

  factory BooksInSeries.fromJson(Map<String, dynamic> json) =>
      _$BooksInSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$BooksInSeriesToJson(this);
}

Future<SeriesDetailsResponse> fetchSeriesBookDetails(int seriesId) async {
  final dio = Dio();

  final allSeriesRes = await dio.get(
    'http://localhost:3000/bookseries/getAllBookSeries',
  );

  final booksRes = await dio.get(
    'http://localhost:3000/bookseries/getBookSeriesById/$seriesId',
  );

  if (allSeriesRes.statusCode == 200 && booksRes.statusCode == 200) {
    final seriesJson = (allSeriesRes.data['bookseries'] as List).firstWhere(
      (s) => s['id'] == seriesId,
    );

    final List<BooksInSeries> books = (booksRes.data['books'] as List)
        .map((b) => BooksInSeries.fromJson(b))
        .toList();

    return SeriesDetailsResponse(
      id: seriesJson['id'],
      series_title: seriesJson['series_title'],
      cover_img: seriesJson['cover_img'],
      state: seriesJson['state'],
      description: seriesJson['description'],
      books: books,
    );
  } else {
    throw Exception('Failed to load series details');
  }
}
