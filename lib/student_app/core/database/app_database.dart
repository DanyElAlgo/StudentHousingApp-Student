import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class AuthTokens extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [AuthTokens])
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
  int get schemaVersion => 1;

  static const int _sessionRowId = 0;

  Future<({String access, String refresh})?> readSession() async {
    final row = await (select(
      authTokens,
    )..where((t) => t.id.equals(_sessionRowId))).getSingleOrNull();
    if (row == null) return null;
    return (access: row.accessToken, refresh: row.refreshToken);
  }

  Future<void> saveSession(String access, String refresh) {
    return into(authTokens).insertOnConflictUpdate(
      AuthTokensCompanion.insert(
        id: const Value(_sessionRowId),
        accessToken: access,
        refreshToken: refresh,
      ),
    );
  }

  Future<void> clearSession() => delete(authTokens).go();
}
