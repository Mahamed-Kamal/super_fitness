import 'package:json_annotation/json_annotation.dart';

part 'upload_profile_message_response.g.dart';

@JsonSerializable()
class UploadProfileMessageResponse {
  @JsonKey(name: "message")
  final String? message;

  UploadProfileMessageResponse({this.message});

  factory UploadProfileMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadProfileMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadProfileMessageResponseToJson(this);
}
