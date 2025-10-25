import 'package:flutter/material.dart';
import 'package:task_yoda/models/menu_option.dart';
import 'package:task_yoda/views/add_task_button.dart';
import 'package:task_yoda/views/my_drawer.dart';
import './task_list.dart';

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
      ),

      drawer: MyDrawer(),

      body: Column(
        children: [
          const Divider(color: Colors.white, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                ['All', 'Work', 'Personal', 'Other']
                    .asMap()
                    .entries
                    .map(
                      (entry) => Menuoption(
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
          Expanded(child: buildTaskList(ind: _selectedIndex)),
        ],
      ),
      floatingActionButton: addTaskButton(),
    );
  }
}
