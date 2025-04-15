import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class buildTaskList extends StatelessWidget {
  const buildTaskList({super.key, required this.ind});
  final int ind;

  @override
  Widget build(BuildContext context) {
    final Box<Task> taskBox = Hive.box<Task>('my_task_box');

    return ValueListenableBuilder(
      valueListenable: taskBox.listenable(),
      builder: (context, Box<Task> box, _) {
        final now = DateTime.now();
        final today = DateUtils.dateOnly(now);
        final String type = switch (ind) {
          1 => 'Work',
          2 => 'Personal',
          3 => 'Other',
          _ => 'All',
        };
        if(taskBox.isEmpty){
          return Padding(
          padding: const EdgeInsets.only(top:12.0,right: 0.0,bottom: 12.0,left: 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/1.png"),
                ),
                Text(
                  'No tasks yet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey
                  ),
                ),

              ],
            ),
          ),
        );
        }
        final tasks = box.values.toList();

        final todayTasks = tasks.where((t) =>
            (t.category == type || type == 'All') &&
            !t.isDone &&
            (DateUtils.dateOnly(t.dateTime) == today || DateUtils.dateOnly(t.dateTime).isBefore(today))
        ).toList();

        final futureTasks = tasks.where((t) =>
            (t.category == type || type == 'All') &&
            !t.isDone &&
            DateUtils.dateOnly(t.dateTime).isAfter(today)
        ).toList();

        final completedTasks = tasks.where((t) =>
            (t.category == type || type == 'All') && t.isDone
        ).toList();

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTile('Today', todayTasks),
                _buildTile('Future', futureTasks),
                _buildTile('Completed', completedTasks),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile(String title, List<Task> tasks) {
    String imagePath;
    switch (title) {
      case 'Today':
        imagePath = 'assets/2.png';
        break;
      case 'Future':
        imagePath = 'assets/3.png';
        break;
      case 'Completed':
        imagePath = 'assets/4.png';
        break;
      default:
        imagePath = 'assets/1.png'; // optional fallback
  }

    return Stack(
      children: [
      Positioned(
        bottom: 60,
        right: 0,
        child: Opacity(
          opacity: 0.4, // Adjust opacity here
          child: Image.asset(
            imagePath,
            width: 130, // Adjust size
            fit: BoxFit.contain,
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8E23),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final formattedDate = DateFormat.yMMMd().format(task.dateTime);
                  final formattedTime = DateFormat.Hm().format(task.dateTime);
        
                  return checkData(
                    task: task,
                    formattedDate: formattedDate,
                    formattedTime: formattedTime,
                    onChanged: () {},
                  );
                },
              ),
            ),
            const Divider(
              color: Color(0xFF2F4F4F),
              height: 12
              ),
          ],
        ),
      ),
      ],
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
      onChanged: (val) {
        setState(() {
          widget.task.isDone = val ?? false;
          widget.task.save();
        });
        widget.onChanged(); 
      },
      dense: true,
      checkboxScaleFactor: 0.8,
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.name,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: widget.task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                        color: Color(0xFF2F4F4F),
                  ),
                ),
                
                const SizedBox(height: 2),
                
                Text(
                  '${widget.task.category} • ${widget.formattedDate} • ${widget.formattedTime}',
                  style: TextStyle(
                    fontSize: 14, 
                    color: Colors.grey[700]
                    ),
                ),

              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete, 
              color: Color(0xFF2F4F4F)
              ),
            onPressed: () {
              widget.task.delete();
              widget.onChanged();
            },
          ),
        ],
      ),
    );
  }
}