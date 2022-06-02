import 'package:todo_list_provider/app/modules/task_model.dart';
import 'package:todo_list_provider/app/modules/week_task_model.dart';

abstract class TasksService{
  Future<void>save(DateTime date,String description);
  Future<List<TaskModel>>getToday();
   Future<List<TaskModel>>getTomorrow();
    Future<WeekTaskModel>getWeek();
    Future<void>checkOrUncheckTask(TaskModel task);

}