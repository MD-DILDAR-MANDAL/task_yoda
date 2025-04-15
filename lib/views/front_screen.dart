import 'package:flutter/material.dart';
import './task_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({super.key});

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8D1A1),
        foregroundColor: const Color(0xFF2F4F4F),
        centerTitle: true,
        title: const Text(
          'Task Yoda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.white, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['All', 'Work', 'Personal', 'Other']
                .asMap()
                .entries
                .map(
                  (entry) => _Menuoption(
                    label: entry.value,
                    isSelected: _selectedIndex == entry.key,
                    onTap: () => _onItemTap(entry.key),
                  ),
                )
                .toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Divider(color: Color(0xFF2F4F4F), height: 20),
          ),
          Expanded(
            child: buildTaskList(ind: _selectedIndex),
          ),
        ],
      ),
      floatingActionButton: _addTaskButton(context),
    );
  }

  Widget _addTaskButton(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: const Color(0xFF2F4F4F),
      backgroundColor: const Color(0xFFA8D1A1),
      child: const Icon(Icons.add),
      onPressed: () {
        final TextEditingController _nameController = TextEditingController();
        final TextEditingController _dateController = TextEditingController();
        DateTime? _selectedDate = DateTime.now();
        String _selectedCategory = 'Work';

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
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
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Enter Your Task'),
                      style: TextStyle(
                        color: Color(0xFF2F4F4F)
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: ['Work', 'Personal', 'Other']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedCategory = val!;
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
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Pick Date & Time'),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate!,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _selectedDate = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              _dateController.text =
                                  DateFormat.yMMMd().add_jm().format(_selectedDate!);
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
                      onPressed: () {
                        final name = _nameController.text.trim();
                        if (name.isEmpty || _selectedDate == null) return;

                        final taskBox = Hive.box<Task>('my_task_box');
                        taskBox.add(Task(
                          category: _selectedCategory,
                          name: name,
                          dateTime: _selectedDate!,
                          isDone: false,
                        ));
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }
}

class _Menuoption extends StatelessWidget {
  const _Menuoption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF6B8E23) : const Color(0xFF2F4F4F);
    final textDecoration =
        isSelected ? TextDecoration.underline : TextDecoration.none;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: color,
              decoration: textDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
