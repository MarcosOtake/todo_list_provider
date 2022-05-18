
class TaskModel{
   final int id;
   final String description;
   final DateTime datetime;
  final bool finished;

  TaskModel({
   required this.id, 
   required this.description,
   required this.datetime,
   required  this.finished,
   });
   factory TaskModel.loadFromDB(Map<String,dynamic>task){
     return TaskModel(
       id: task ['id'],
        description:task ['description'],
         datetime: DateTime.parse(task['data_hora']),
          finished: task['finalizado']== 1,
          );
   }
}