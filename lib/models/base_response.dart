import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class RootResponse {
  String? message;

  RootResponse({this.message});

  factory RootResponse.fromJson(Map<String, dynamic> json) =>
      _$RootResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RootResponseToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class AppResponse<T> extends RootResponse {
  T? data;

  AppResponse({super.message, this.data});

  factory AppResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return AppResponse<T>(message: json["message"], data: create(json["data"]));
  }
}

@JsonSerializable(genericArgumentFactories: true)
class AppResponses<T> extends RootResponse {
  List<T>? data;

  AppResponses({super.message, this.data});

  factory AppResponses.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    var data = <T>[];
    json['data'].forEach((v) {
      data.add(create(v));
    });

    return AppResponses<T>(message: json["message"], data: data);
  }
}
