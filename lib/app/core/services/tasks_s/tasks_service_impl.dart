// ignore_for_file: prefer_const_constructors

import 'package:todo_list_provider/app/core/repositories/tasks_r/tasks_repository.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service.dart';
import 'package:todo_list_provider/app/modules/task_model.dart';
import 'package:todo_list_provider/app/modules/week_task_model.dart';

class TasksServiceImpl implements TasksService{
final TasksRepository _tasksRepository;
TasksServiceImpl({
  required TasksRepository tasksRepository,
}):_tasksRepository = tasksRepository;


@override
  Future<void> save(DateTime date, String description) =>
  _tasksRepository.save(date, description);


  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
   
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(Duration(days:1));
  return _tasksRepository.findByPeriod(tomorrowDate,tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async{
    final today= DateTime.now();
    var startFilter = DateTime(today.year,today.month,today.day,0,0,0);
    DateTime endFilter;
    if(startFilter.weekday != DateTime.monday){
      startFilter = startFilter.subtract(Duration(days: (startFilter.weekday - 1)));

    }
      endFilter = startFilter.add(Duration(days:7));
      final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
      return WeekTaskModel(
        startDate: startFilter,
         endDate: endFilter,
          tasks: tasks,
          );
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task)=>_tasksRepository.checkOrUncheckTask(task); 
  }

  


