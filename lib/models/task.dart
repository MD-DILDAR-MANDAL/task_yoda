import 'package:hive/hive.dart';

part 'task.g.dart';

class Task extends HiveObject{
@HiveField(0)
String category;

@HiveField(1)
String name;

}