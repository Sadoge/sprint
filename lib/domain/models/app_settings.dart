import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(15) int sprintDuration,
    @Default(true) bool soundEnabled,
  }) = _AppSettings;
}
