// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dezurnaVozila.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DezurnaVozila _$DezurnaVozilaFromJson(Map<String, dynamic> json) =>
    DezurnaVozila()
      ..dezurnoVoziloId = json['dezurnoVoziloId'] as int?
      ..nazivDezurnogVozila = json['nazivDezurnogVozila'] as String?
      ..tipVozila = json['tipVozila'] as String?;

Map<String, dynamic> _$DezurnaVozilaToJson(DezurnaVozila instance) =>
    <String, dynamic>{
      'dezurnoVoziloId': instance.dezurnoVoziloId,
      'nazivDezurnogVozila': instance.nazivDezurnogVozila,
      'tipVozila': instance.tipVozila,
    };
