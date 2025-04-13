import 'package:flutter/material.dart';

class buildTaskList extends StatelessWidget {
  const buildTaskList({required this.ind, super.key});

  final int ind;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('hi......$ind....'),
        SizedBox(
          child: _buildList()
          ),
      ],
    );
  }
  
  Widget _buildList() {
    
    return ListView();
  }
}