import 'package:todo_list_provider/app/modules/task_model.dart';

abstract class TasksRepository{
  Future<void>save(DateTime date,String description);
  Future<List<TaskModel>>findByPeriod(DateTime start,DateTime end);

}