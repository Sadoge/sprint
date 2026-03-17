import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprint/core/design_system/theme.dart';
import 'package:sprint/domain/models/app_settings.dart';
import 'package:sprint/domain/repositories/settings_repository.dart';
import 'package:sprint/domain/repositories/sprint_repository.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

DateTime normalizeDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

void disableRuntimeFontFetching() {
  GoogleFonts.config.allowRuntimeFetching = false;
}

Widget buildTestApp(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: sprintDarkTheme,
      home: Scaffold(body: child),
    ),
  );
}

class FakeSprintRepository implements SprintRepository {
  FakeSprintRepository({Map<DateTime, int>? history, DateTime Function()? now})
    : _now = now ?? DateTime.now {
    if (history != null) {
      for (final entry in history.entries) {
        _history[normalizeDate(entry.key)] = entry.value;
      }
    }
  }

  final DateTime Function() _now;
  final Map<DateTime, int> _history = <DateTime, int>{};
  final List<int> recordedDurations = <int>[];
  int clearAllCalls = 0;
  Object? recordError;
  Object? historyError;

  Map<DateTime, int> get historyView =>
      Map<DateTime, int>.unmodifiable(_history);

  @override
  Future<void> recordSprint(int durationMinutes) async {
    if (recordError != null) {
      throw recordError!;
    }

    recordedDurations.add(durationMinutes);
    final today = normalizeDate(_now());
    _history[today] = (_history[today] ?? 0) + 1;
  }

  @override
  Future<Map<DateTime, int>> getLast30Days() async {
    if (historyError != null) {
      throw historyError!;
    }

    return Map<DateTime, int>.from(_history);
  }

  @override
  Future<int> getTotalSprints() async {
    return _history.values.fold<int>(0, (sum, count) => sum + count);
  }

  @override
  Future<int> getActiveDays() async {
    return _history.entries.where((entry) => entry.value > 0).length;
  }

  @override
  Future<void> clearAll() async {
    clearAllCalls++;
    _history.clear();
  }
}

class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository({AppSettings? initialSettings})
    : settings = initialSettings ?? const AppSettings();

  AppSettings settings;
  final List<AppSettings> savedSettings = <AppSettings>[];
  Object? getError;

  @override
  Future<AppSettings> getSettings() async {
    if (getError != null) {
      throw getError!;
    }

    return settings;
  }

  @override
  Future<void> saveSettings(AppSettings newSettings) async {
    settings = newSettings;
    savedSettings.add(newSettings);
  }
}

class FakeCompletionSoundPlayer implements CompletionSoundPlayer {
  int playCalls = 0;
  int disposeCalls = 0;
  Object? playError;

  @override
  Future<void> play() async {
    playCalls++;
    if (playError != null) {
      throw playError!;
    }
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
  }
}
