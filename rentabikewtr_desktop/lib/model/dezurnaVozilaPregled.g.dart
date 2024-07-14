// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dezurnaVozilaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DezurnaVozilaPregled _$DezurnaVozilaPregledFromJson(
        Map<String, dynamic> json) =>
    DezurnaVozilaPregled()
      ..dezurnoVoziloId = (json['dezurnoVoziloId'] as num?)?.toInt()
      ..nazivDezurnogVozila = json['nazivDezurnogVozila'] as String?
      ..tipVozila = json['tipVozila'] as String?;

Map<String, dynamic> _$DezurnaVozilaPregledToJson(
        DezurnaVozilaPregled instance) =>
    <String, dynamic>{
      'dezurnoVoziloId': instance.dezurnoVoziloId,
      'nazivDezurnogVozila': instance.nazivDezurnogVozila,
      'tipVozila': instance.tipVozila,
    };
