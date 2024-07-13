// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalModel _$JournalModelFromJson(Map<String, dynamic> json) => JournalModel(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ListJournalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: json['size'] as String?,
      page: json['page'] as String?,
      totalElements: json['totalElements'] as String?,
      totalPages: json['totalPages'] as String?,
    );

Map<String, dynamic> _$JournalModelToJson(JournalModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'page': instance.page,
      'size': instance.size,
      'content': instance.content,
    };

ListJournalData _$ListJournalDataFromJson(Map<String, dynamic> json) =>
    ListJournalData(
      body: json['body'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      createdBy: json['createdBy'] as String?,
      dateCreated: json['dateCreated'] as String?,
      version: json['version'] as int?,
      dateModified: json['dateModified'] as String?,
      dateOfEntry: json['dateOfEntry'] as String?,
      dateUpdated: json['dateUpdated'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ListJournalDataToJson(ListJournalData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'dateOfEntry': instance.dateOfEntry,
      'dateCreated': instance.dateCreated,
      'dateUpdated': instance.dateUpdated,
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'dateModified': instance.dateModified,
      'createdBy': instance.createdBy,
    };
