// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikiData _$WikiDataFromJson(Map<String, dynamic> json) {
  return WikiData(
    batchcomplete: json['batchcomplete'] as bool,
    wikiDataContinue:
        Continue.fromJson(json['wikiDataContinue'] as Map<String, dynamic>),
    query: Query.fromJson(json['query'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WikiDataToJson(WikiData instance) => <String, dynamic>{
      'batchcomplete': instance.batchcomplete,
      'wikiDataContinue': instance.wikiDataContinue,
      'query': instance.query,
    };
