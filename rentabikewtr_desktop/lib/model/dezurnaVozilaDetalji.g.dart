// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dezurnaVozilaDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DezurnaVozilaDetalji _$DezurnaVozilaDetaljiFromJson(
        Map<String, dynamic> json) =>
    DezurnaVozilaDetalji(
      (json['dezurnoVoziloId'] as num?)?.toInt(),
      json['nazivDezurnogVozila'] as String?,
      json['tipVozila'] as String?,
    );

Map<String, dynamic> _$DezurnaVozilaDetaljiToJson(
        DezurnaVozilaDetalji instance) =>
    <String, dynamic>{
      'dezurnoVoziloId': instance.dezurnoVoziloId,
      'nazivDezurnogVozila': instance.nazivDezurnogVozila,
      'tipVozila': instance.tipVozila,
    };
