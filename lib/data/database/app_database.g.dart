// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SprintsTable extends Sprints with TableInfo<$SprintsTable, Sprint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SprintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, completedAt, durationMinutes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sprints';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sprint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sprint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sprint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
    );
  }

  @override
  $SprintsTable createAlias(String alias) {
    return $SprintsTable(attachedDatabase, alias);
  }
}

class Sprint extends DataClass implements Insertable<Sprint> {
  final int id;
  final DateTime completedAt;
  final int durationMinutes;
  const Sprint({
    required this.id,
    required this.completedAt,
    required this.durationMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    return map;
  }

  SprintsCompanion toCompanion(bool nullToAbsent) {
    return SprintsCompanion(
      id: Value(id),
      completedAt: Value(completedAt),
      durationMinutes: Value(durationMinutes),
    );
  }

  factory Sprint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sprint(
      id: serializer.fromJson<int>(json['id']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
    };
  }

  Sprint copyWith({int? id, DateTime? completedAt, int? durationMinutes}) =>
      Sprint(
        id: id ?? this.id,
        completedAt: completedAt ?? this.completedAt,
        durationMinutes: durationMinutes ?? this.durationMinutes,
      );
  Sprint copyWithCompanion(SprintsCompanion data) {
    return Sprint(
      id: data.id.present ? data.id.value : this.id,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sprint(')
          ..write('id: $id, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationMinutes: $durationMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, completedAt, durationMinutes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sprint &&
          other.id == this.id &&
          other.completedAt == this.completedAt &&
          other.durationMinutes == this.durationMinutes);
}

class SprintsCompanion extends UpdateCompanion<Sprint> {
  final Value<int> id;
  final Value<DateTime> completedAt;
  final Value<int> durationMinutes;
  const SprintsCompanion({
    this.id = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
  });
  SprintsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime completedAt,
    required int durationMinutes,
  }) : completedAt = Value(completedAt),
       durationMinutes = Value(durationMinutes);
  static Insertable<Sprint> custom({
    Expression<int>? id,
    Expression<DateTime>? completedAt,
    Expression<int>? durationMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (completedAt != null) 'completed_at': completedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
    });
  }

  SprintsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? completedAt,
    Value<int>? durationMinutes,
  }) {
    return SprintsCompanion(
      id: id ?? this.id,
      completedAt: completedAt ?? this.completedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SprintsCompanion(')
          ..write('id: $id, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationMinutes: $durationMinutes')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sprintDurationMeta = const VerificationMeta(
    'sprintDuration',
  );
  @override
  late final GeneratedColumn<int> sprintDuration = GeneratedColumn<int>(
    'sprint_duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, sprintDuration, soundEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sprint_duration')) {
      context.handle(
        _sprintDurationMeta,
        sprintDuration.isAcceptableOrUnknown(
          data['sprint_duration']!,
          _sprintDurationMeta,
        ),
      );
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sprintDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sprint_duration'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final int sprintDuration;
  final bool soundEnabled;
  const Setting({
    required this.id,
    required this.sprintDuration,
    required this.soundEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sprint_duration'] = Variable<int>(sprintDuration);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      sprintDuration: Value(sprintDuration),
      soundEnabled: Value(soundEnabled),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      sprintDuration: serializer.fromJson<int>(json['sprintDuration']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sprintDuration': serializer.toJson<int>(sprintDuration),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
    };
  }

  Setting copyWith({int? id, int? sprintDuration, bool? soundEnabled}) =>
      Setting(
        id: id ?? this.id,
        sprintDuration: sprintDuration ?? this.sprintDuration,
        soundEnabled: soundEnabled ?? this.soundEnabled,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      sprintDuration: data.sprintDuration.present
          ? data.sprintDuration.value
          : this.sprintDuration,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('sprintDuration: $sprintDuration, ')
          ..write('soundEnabled: $soundEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sprintDuration, soundEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.sprintDuration == this.sprintDuration &&
          other.soundEnabled == this.soundEnabled);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<int> sprintDuration;
  final Value<bool> soundEnabled;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.sprintDuration = const Value.absent(),
    this.soundEnabled = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.sprintDuration = const Value.absent(),
    this.soundEnabled = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<int>? sprintDuration,
    Expression<bool>? soundEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sprintDuration != null) 'sprint_duration': sprintDuration,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? sprintDuration,
    Value<bool>? soundEnabled,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      sprintDuration: sprintDuration ?? this.sprintDuration,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sprintDuration.present) {
      map['sprint_duration'] = Variable<int>(sprintDuration.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('sprintDuration: $sprintDuration, ')
          ..write('soundEnabled: $soundEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SprintsTable sprints = $SprintsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final SprintDao sprintDao = SprintDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sprints, settings];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SprintsTableCreateCompanionBuilder =
    SprintsCompanion Function({
      Value<int> id,
      required DateTime completedAt,
      required int durationMinutes,
    });
typedef $$SprintsTableUpdateCompanionBuilder =
    SprintsCompanion Function({
      Value<int> id,
      Value<DateTime> completedAt,
      Value<int> durationMinutes,
    });

class $$SprintsTableFilterComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SprintsTableOrderingComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SprintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );
}

class $$SprintsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SprintsTable,
          Sprint,
          $$SprintsTableFilterComposer,
          $$SprintsTableOrderingComposer,
          $$SprintsTableAnnotationComposer,
          $$SprintsTableCreateCompanionBuilder,
          $$SprintsTableUpdateCompanionBuilder,
          (Sprint, BaseReferences<_$AppDatabase, $SprintsTable, Sprint>),
          Sprint,
          PrefetchHooks Function()
        > {
  $$SprintsTableTableManager(_$AppDatabase db, $SprintsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SprintsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SprintsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SprintsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
              }) => SprintsCompanion(
                id: id,
                completedAt: completedAt,
                durationMinutes: durationMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime completedAt,
                required int durationMinutes,
              }) => SprintsCompanion.insert(
                id: id,
                completedAt: completedAt,
                durationMinutes: durationMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SprintsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SprintsTable,
      Sprint,
      $$SprintsTableFilterComposer,
      $$SprintsTableOrderingComposer,
      $$SprintsTableAnnotationComposer,
      $$SprintsTableCreateCompanionBuilder,
      $$SprintsTableUpdateCompanionBuilder,
      (Sprint, BaseReferences<_$AppDatabase, $SprintsTable, Sprint>),
      Sprint,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<int> sprintDuration,
      Value<bool> soundEnabled,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<int> sprintDuration,
      Value<bool> soundEnabled,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sprintDuration => $composableBuilder(
    column: $table.sprintDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sprintDuration => $composableBuilder(
    column: $table.sprintDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sprintDuration => $composableBuilder(
    column: $table.sprintDuration,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sprintDuration = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                sprintDuration: sprintDuration,
                soundEnabled: soundEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sprintDuration = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                sprintDuration: sprintDuration,
                soundEnabled: soundEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SprintsTableTableManager get sprints =>
      $$SprintsTableTableManager(_db, _db.sprints);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
