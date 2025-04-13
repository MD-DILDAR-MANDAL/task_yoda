import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class buildTaskList extends StatelessWidget {
  const buildTaskList({required this.ind, super.key});
  final int ind;
  
  @override
  Widget build(BuildContext context) {
    //getting refererence to an already opened Box
    final Box<Task> taskBox = Hive.box<Task>('myTaskBox');
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);

    if (taskBox.isEmpty) {
    taskBox.addAll([
      Task(
        category: 'Work',
        name: 'Submit report',
        dateTime: DateTime.now(),
        isDone: false,
      ),
      Task(
        category: 'Personal',
        name: 'Buy groceries',
        dateTime: DateTime.now().add(Duration(days: 1)),
        isDone: false,
      ),
      Task(
        category: 'Work',
        name: 'Team meeting',
        dateTime: DateTime.now().subtract(Duration(days: 1)),
        isDone: true,
      ),
    ]);
    }

    final tasks = taskBox.values.toList();

    final todayTasks = tasks
    .where((t) => !t.isDone 
    && DateUtils.dateOnly(t.dateTime)==today).toList();

    final futureTasks = tasks
    .where((t) => !t.isDone 
    && DateUtils.dateOnly(t.dateTime).isAfter(today)).toList();
    
    final completedTasks = tasks.where((t)=>t.isDone).toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          
          Text('Today'),
          _buildList(todayTasks),
          
          SizedBox(height: 10,),
          Text('Future'),
          _buildList(futureTasks),

          SizedBox(height: 10,),
          Text('Completed'),
          _buildList(completedTasks),

        ],
      ),
    );
  }
  
  Widget _buildList(List<Task>tasks){
    
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        final task = tasks[index];
        final formattedDate = 
        DateFormat.yMMMd().format(task.dateTime);
        final formattedTime = 
        DateFormat.Hm().format(task.dateTime);

        return CheckboxListTile(
          value: task.isDone,
          onChanged: (val){
            task.isDone = val?? false;
            task.save();
          },
          title: Text(task.name),
          subtitle: Text('$task.category . $formattedDate . $formattedTime'),
        );
      },
    );
  }
}