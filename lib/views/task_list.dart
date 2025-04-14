
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class buildTaskList extends StatefulWidget {
  const buildTaskList({required this.ind, super.key});
  final int ind;

  @override
  State<buildTaskList> createState() => _buildTaskListState();
}

class _buildTaskListState extends State<buildTaskList> {
  @override
  Widget build(BuildContext context) {
    //getting refererence to an already opened Box
    final Box <Task> taskBox = Hive.box('my_task_box');
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final String type = switch(widget.ind){
      1 => 'Work',
      2 => 'Personal',
      3 => 'Other',
      _ => 'All',
    };
    //taskBox.clear();
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
      Task(
        category: 'Work',
        name: 'Study Dsa',
        dateTime: DateTime.now(),
        isDone: false,
      ),
      Task(
        category: 'Personal',
        name: 'Buy surf',
        dateTime: DateTime.now(),
        isDone: false,
      ),
      Task(
        category: 'Other',
        name: 'Riding',
        dateTime: DateTime.now().add(Duration(days: 2)),
        isDone: true,
      ),
    ]);
    }

    final tasks = taskBox.values.toList();

    final todayTasks = tasks
    .where((t) => (t.category==type||type == 'All') && !t.isDone 
    && ((DateUtils.dateOnly(t.dateTime)==today)||(DateUtils.dateOnly(t.dateTime).isBefore(today)))).toList();

    final futureTasks = tasks
    .where((t) => (t.category==type||type == 'All') && !t.isDone 
    && DateUtils.dateOnly(t.dateTime).isAfter(today)).toList();
    
    final completedTasks = tasks.where((t)=>
    (t.category==type||type == 'All') && t.isDone).toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTile('Today', todayTasks),
            _buildTile('Future', futureTasks),
            _buildTile('Completed', completedTasks)
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String title, List<Task>tasks){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
            Text(title,
              style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8E23), 
              ),
            ),
            SizedBox(
              height:140,
              child: _buildList(tasks)
              ),
            Divider(
              color: Color(0xFF2F4F4F),
              height: 10,
            ),
      ],
    );
  }

  Widget _buildList(List<Task>tasks){
    
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context,index){
        final task = tasks[index];
        final formattedDate = 
        DateFormat.yMMMd().format(task.dateTime);
        final formattedTime = 
        DateFormat.Hm().format(task.dateTime);

        return checkData(
          task: task, 
          formattedDate: formattedDate, 
          formattedTime: formattedTime,
          onChanged: ()=>setState(() { }),
        );
      },
    );
  }
}

class checkData extends StatefulWidget {
  const checkData({
    super.key,
    required this.task,
    required this.formattedDate,
    required this.formattedTime,
    required this.onChanged,
  });

  final Task task;
  final String formattedDate;
  final String formattedTime;
  final VoidCallback onChanged;

  @override
  State<checkData> createState() => _checkDataState();
}

class _checkDataState extends State<checkData> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.task.isDone,
      onChanged: (val){
        setState(() {
          widget.task.isDone = val?? false;
          widget.task.save();          
        });
        widget.onChanged();
      },
      dense: true,
      checkboxScaleFactor: 0.8,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.task.name,
      style: TextStyle(
        fontSize: 16,
        decoration: widget.task.isDone
        ?TextDecoration.lineThrough:TextDecoration.none,
        ),
      ),
      subtitle: Text('${widget.task.category} . ${widget.formattedDate} . ${widget.formattedTime}'),
    );
  }
}