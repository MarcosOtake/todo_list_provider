import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository.dart';
import 'package:todo_list_provider/app/modules/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    var conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert("todo", {
      "id": null,
      "descricao": description,
      "data_hora": date.toIso8601String(),
      "finalizado": 0
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    var startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    var endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    var conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
        '''select * from todo where data_hora between ? and ?  order by data_hora ''',
        [startFilter.toIso8601String(), endFilter.toIso8601String()]);
    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
}
