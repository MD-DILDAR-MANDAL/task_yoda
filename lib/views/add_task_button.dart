import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_yoda/models/task.dart';

class addTaskButton extends StatelessWidget {
  addTaskButton();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: const Color(0xFF2F4F4F),
      backgroundColor: const Color(0xFFA8D1A1),
      child: const Icon(Icons.add),
      onPressed: () {
        DateTime? selectedDate = DateTime.now();
        String selectedCategory = 'Work';

        MyBottomSheet(
          context,
          nameController,
          selectedCategory,
          dateController,
          selectedDate,
        );
      },
    );
  }

  Future<dynamic> MyBottomSheet(
    BuildContext context,
    TextEditingController nameController,
    String selectedCategory,
    TextEditingController dateController,
    DateTime? selectedDate,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F4F4F),
                    ),
                  ),

                  TextField(
                    controller: nameController,

                    decoration: const InputDecoration(
                      labelText: 'Enter Your Task',
                      border: OutlineInputBorder(),
                      focusColor: Color(0xFF6B8E23),
                    ),
                    style: TextStyle(color: Color(0xFF2F4F4F)),
                  ),

                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items:
                        ['Work', 'Personal', 'Other']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Category'),
                    style: TextStyle(
                      color: Color(0xFF2F4F4F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Pick Date & Time',
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate!,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          // ignore: use_build_context_synchronously
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            dateController.text = DateFormat.yMMMd()
                                .add_jm()
                                .format(selectedDate!);
                          });
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF2F4F4F),
                      backgroundColor: const Color(0xFFA8D1A1),
                    ),
                    child: const Text('Add Task'),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isEmpty || selectedDate == null) return;

                      final taskBox = Hive.box<Task>('my_task_box');
                      taskBox.add(
                        Task(
                          category: selectedCategory,
                          name: name,
                          dateTime: selectedDate!,
                          isDone: false,
                        ),
                      );
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
