// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponseDto _$SuccessResponseDtoFromJson(Map<String, dynamic> json) =>
    SuccessResponseDto(message: json['message'] as String?);

Map<String, dynamic> _$SuccessResponseDtoToJson(SuccessResponseDto instance) =>
    <String, dynamic>{'message': instance.message};

FailureResponseDto _$FailureResponseDtoFromJson(Map<String, dynamic> json) =>
    FailureResponseDto(error: json['error'] as String?);

Map<String, dynamic> _$FailureResponseDtoToJson(FailureResponseDto instance) =>
    <String, dynamic>{'error': instance.error};
