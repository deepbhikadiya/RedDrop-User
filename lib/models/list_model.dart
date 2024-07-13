import 'package:json_annotation/json_annotation.dart';

part 'list_model.g.dart';
@JsonSerializable()
class JournalModel {
  String? totalElements;
  String? totalPages;
  String? page;
  String? size;
  List<ListJournalData>? content;

  JournalModel({this.content,this.size,this.page,this.totalElements,this.totalPages});
  factory JournalModel.fromJson(Map<String, dynamic> json) =>
      _$JournalModelFromJson(json);

  Map<String, dynamic> toJson() => _$JournalModelToJson(this);
}


@JsonSerializable()
class ListJournalData {
  String? title;
  String? body;
  String? dateOfEntry;
  String? dateCreated;
  String? dateUpdated;
  int? id;
  int? version;
  String? name;
  String? dateModified;
  String? createdBy;


  ListJournalData(
      {this.body,this.name,this.title,this.createdBy,this.dateCreated,this.version,this.dateModified,this.dateOfEntry,this.dateUpdated,this.id});

  factory ListJournalData.fromJson(Map<String, dynamic> json) =>
      _$ListJournalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListJournalDataToJson(this);
}