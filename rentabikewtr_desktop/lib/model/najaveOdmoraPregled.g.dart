// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'najaveOdmoraPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NajaveOdmoraPregled _$NajaveOdmoraPregledFromJson(Map<String, dynamic> json) =>
    NajaveOdmoraPregled()
      ..najavaOdmoraId = (json['najavaOdmoraId'] as num?)?.toInt()
      ..datumOdmora = json['datumOdmora'] == null
          ? null
          : DateTime.parse(json['datumOdmora'] as String)
      ..pocetakOdmora = json['pocetakOdmora'] == null
          ? null
          : DateTime.parse(json['pocetakOdmora'] as String)
      ..zavrsetakOdmora = json['zavrsetakOdmora'] == null
          ? null
          : DateTime.parse(json['zavrsetakOdmora'] as String)
      ..napitakKolicina = (json['napitakKolicina'] as num?)?.toInt()
      ..launchPaketKolicina = (json['launchPaketKolicina'] as num?)?.toInt()
      ..lokacijaOdmoraID = (json['lokacijaOdmoraID'] as num?)?.toInt()
      ..nazivLokacije = json['nazivLokacije'] as String?
      ..turistickiVodicID = (json['turistickiVodicID'] as num?)?.toInt()
      ..nazivVodica = json['nazivVodica'] as String?;

Map<String, dynamic> _$NajaveOdmoraPregledToJson(
        NajaveOdmoraPregled instance) =>
    <String, dynamic>{
      'najavaOdmoraId': instance.najavaOdmoraId,
      'datumOdmora': instance.datumOdmora?.toIso8601String(),
      'pocetakOdmora': instance.pocetakOdmora?.toIso8601String(),
      'zavrsetakOdmora': instance.zavrsetakOdmora?.toIso8601String(),
      'napitakKolicina': instance.napitakKolicina,
      'launchPaketKolicina': instance.launchPaketKolicina,
      'lokacijaOdmoraID': instance.lokacijaOdmoraID,
      'nazivLokacije': instance.nazivLokacije,
      'turistickiVodicID': instance.turistickiVodicID,
      'nazivVodica': instance.nazivVodica,
    };
