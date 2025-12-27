import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
part 'SeriesResponse.g.dart';

@JsonSerializable()
class SeriesResponse {
  final int? id;
  final String? series_title;
  final String? cover_img;
  final String? state;

  SeriesResponse({this.id, this.series_title, this.cover_img, this.state});

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesResponseToJson(this);
}

Future<List<SeriesResponse>> fetchAllSeries() async {
  final dio = Dio();

  final response = await dio.get(
    'http://localhost:3000/bookseries/getAllBookSeries',
  );

  if (response.statusCode == 200) {
    final List seriesList = response.data['bookseries'];
    return seriesList.map((series) => SeriesResponse.fromJson(series)).toList();
  } else {
    throw Exception('Failed to load book series');
  }
}
