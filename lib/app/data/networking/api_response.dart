import 'package:axlpl_delivery/app/data/networking/api_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class APIResponse<T> with _$APIResponse<T> {
  const factory APIResponse.success(T data) = _Success<T>;
  const factory APIResponse.error(AppException error) = _Error<T>;
}
