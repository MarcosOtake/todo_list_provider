import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migrations.dart';

class MigrationV2 implements Migrations {
  @override
  void create(Batch batch) {
    batch.execute('create table teste(id integer');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste(id integer');
  }
}
