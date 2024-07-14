// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xRezervacijeResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XRezervacijeResult _$XRezervacijeResultFromJson(Map<String, dynamic> json) =>
    XRezervacijeResult()
      ..ukupnaSuma = json['ukupnaSuma'] as num?
      ..xRezervacijeLista = (json['xRezervacijeLista'] as List<dynamic>?)
          ?.map((e) => XRezervacije.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$XRezervacijeResultToJson(XRezervacijeResult instance) =>
    <String, dynamic>{
      'ukupnaSuma': instance.ukupnaSuma,
      'xRezervacijeLista': instance.xRezervacijeLista,
    };
