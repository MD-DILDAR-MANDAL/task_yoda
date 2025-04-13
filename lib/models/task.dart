import 'package:hive/hive.dart';

///model class annotation

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
    
  Task({
  required this.category, 
  required this.name, 
  required this.dateTime, 
  this.isDone = false,
  });

  @HiveField(0)
  String category;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  bool isDone;
}