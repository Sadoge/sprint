// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'b43f5a38382427710fbceefeb419518e859b35ea';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<AppDatabase>;
String _$sprintRepositoryHash() => r'fdb46d3fe354cb2dda2aa08d39007b0a313cc40c';

/// See also [sprintRepository].
@ProviderFor(sprintRepository)
final sprintRepositoryProvider = AutoDisposeProvider<SprintRepository>.internal(
  sprintRepository,
  name: r'sprintRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sprintRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SprintRepositoryRef = AutoDisposeProviderRef<SprintRepository>;
String _$settingsRepositoryHash() =>
    r'508508aa65996dc984d321951a06746cb000161c';

/// See also [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider =
    AutoDisposeProvider<SettingsRepository>.internal(
      settingsRepository,
      name: r'settingsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = AutoDisposeProviderRef<SettingsRepository>;
String _$timerViewModelHash() => r'e3c3dd4117bfb7e6e8618f3f29ceeb290dcd7e38';

/// See also [TimerViewModel].
@ProviderFor(TimerViewModel)
final timerViewModelProvider =
    AutoDisposeAsyncNotifierProvider<TimerViewModel, TimerState>.internal(
      TimerViewModel.new,
      name: r'timerViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timerViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TimerViewModel = AutoDisposeAsyncNotifier<TimerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
