import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migrations.dart';

class MigrationV3 implements Migrations {
  @override
  void create(Batch batch) {
    batch.execute('create table teste2(id integer');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste2(id integer');
  }
}
