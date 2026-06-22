import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class CachedConversations extends Table {
  IntColumn get chatId => integer()();
  TextColumn get otherParticipantId => text()();
  TextColumn get otherParticipantName => text()();
  TextColumn get otherParticipantImageUrl =>
      text().withDefault(const Constant(''))();
  TextColumn get lastMessage => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {chatId};
}

class CachedMessages extends Table {
  IntColumn get id => integer()();
  IntColumn get chatId => integer()();
  TextColumn get senderId => text()();
  TextColumn get senderName => text()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get languageCode => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [CachedConversations, CachedMessages, AppSettings],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'student_db',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  AppDatabase.forExecutor(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(cachedConversations);
        await m.createTable(cachedMessages);
      }
      if (from < 3) {
        await m.createTable(appSettings);
      }
      if (from < 4) {
        await m.deleteTable('auth_tokens');
      }
      if (from < 5) {
        await m.addColumn(
          cachedConversations,
          cachedConversations.otherParticipantImageUrl,
        );
      }
    },
  );

  static const int _settingsRowId = 0;

  Future<String?> readLanguageCode() async {
    final row = await (select(
      appSettings,
    )..where((t) => t.id.equals(_settingsRowId))).getSingleOrNull();
    return row?.languageCode;
  }

  Future<void> saveLanguageCode(String code) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(
        id: const Value(_settingsRowId),
        languageCode: Value(code),
      ),
    );
  }

  Stream<List<CachedConversation>> watchCachedConversations() {
    return (select(cachedConversations)..orderBy([
      (t) => OrderingTerm(
        expression: t.lastMessageAt,
        mode: OrderingMode.desc,
      ),
    ])).watch();
  }

  Future<CachedConversation?> getCachedConversation(int chatId) {
    return (select(
      cachedConversations,
    )..where((t) => t.chatId.equals(chatId))).getSingleOrNull();
  }

  Future<void> upsertCachedConversations(
    List<CachedConversationsCompanion> rows,
  ) async {
    await batch((b) {
      for (final row in rows) {
        b.insert(cachedConversations, row, onConflict: DoUpdate((_) => row));
      }
    });
  }

  Future<void> upsertCachedConversation(CachedConversationsCompanion row) {
    return into(
      cachedConversations,
    ).insert(row, onConflict: DoUpdate((_) => row));
  }

  Future<List<CachedMessage>> getCachedMessages(
    int chatId, {
    int? beforeId,
    int limit = 30,
  }) {
    final query = select(cachedMessages)
      ..where((t) => t.chatId.equals(chatId))
      ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
      ..limit(limit);
    if (beforeId != null) {
      query.where((t) => t.id.isSmallerThanValue(beforeId));
    }
    return query.get();
  }

  Stream<List<CachedMessage>> watchCachedMessages(int chatId) {
    return (select(cachedMessages)
          ..where((t) => t.chatId.equals(chatId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<void> upsertCachedMessages(List<CachedMessagesCompanion> rows) async {
    await batch((b) {
      for (final row in rows) {
        b.insert(cachedMessages, row, onConflict: DoUpdate((_) => row));
      }
    });
  }

  Future<void> clearChatData() async {
    await delete(cachedMessages).go();
    await delete(cachedConversations).go();
  }
}
