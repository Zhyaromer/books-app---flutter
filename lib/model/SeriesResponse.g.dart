// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SeriesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) =>
    SeriesResponse(
      id: (json['id'] as num?)?.toInt(),
      series_title: json['series_title'] as String?,
      cover_img: json['cover_img'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$SeriesResponseToJson(SeriesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series_title': instance.series_title,
      'cover_img': instance.cover_img,
      'state': instance.state,
    };
