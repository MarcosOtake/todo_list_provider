
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/services/tasks_s/tasks_service.dart';
import 'package:todo_list_provider/app/modules/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/task_model.dart';
import 'package:todo_list_provider/app/modules/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/week_task_model.dart';

class HomeController extends DefaultChangeNotifier{
  final TasksService _tasksService;
var filterSelected = TaskFilterEnum.today; 
TotalTasksModel? todayTotalTasks;
TotalTasksModel? tomorrowTotalTasks;
TotalTasksModel? weekTotalTasks;


  HomeController({required TasksService tasksService})
  :_tasksService = tasksService;

  


 Future<void> loadTotalTasks()async{
  final allTasks = await Future.wait([
_tasksService.getToday(),
_tasksService.getTomorrow(),
_tasksService.getWeek(),


  ]);
final todayTasks = allTasks[0]as List<TaskModel>;
final tomorrowTasks = allTasks[1]as List<TaskModel>;
final weekTasks = allTasks[2]as WeekTaskModel;

  todayTotalTasks = TotalTasksModel(
  totalTasks:  todayTasks.length,
   totalTasksFinish:  todayTasks.where((task) => task.finished).length,
   );
  tomorrowTotalTasks  = TotalTasksModel(
  totalTasks:  tomorrowTasks.length,
   totalTasksFinish:  tomorrowTasks.where((task) => task.finished).length,
   );
  weekTotalTasks = TotalTasksModel(
  totalTasks:  weekTasks.tasks.length,
   totalTasksFinish:   weekTasks.tasks.where((task) => task.finished).length,
   );
   notifyListeners();
}

}