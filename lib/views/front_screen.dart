import 'package:flutter/material.dart';
import './task_list.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA8D1A1),
        foregroundColor: Color(0xFF2F4F4F),
        centerTitle: true,
        title: Text('Task Yoda',
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
        actions: [
          IconButton(
            onPressed:(){
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
               );
            },
           icon: const Icon(Icons.search),
           ),
        ],
        /*add it later*/
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.menu)),
      ),
      body: _buildTaskType(),
   
    );
  }
}

/*add it later*/
class CustomSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}

class _buildTaskType extends StatefulWidget {
  const _buildTaskType({super.key});

  @override
  State<_buildTaskType> createState() => __buildTaskTypeState();
}

class __buildTaskTypeState extends State<_buildTaskType> {
  
  int _selectedIndex = 0;

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ['All','Work','Personal','Other'];

    return Column(
      children: [
        Divider(
          color: Colors.white,
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length,(index){
            return _Menuoption(
              label: items[index], 
              isSelected: _selectedIndex == index,
              onTap: () =>_onItemTap(index),
            );
          }),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Divider(
              color: Color(0xFF2F4F4F),
              height: 20,
            ),
          ),
        ),

        Column(
          children: [
            buildTaskList(ind: _selectedIndex),
          ],
        ),
      ],
    );
  }
}

///this is inside the List.generate constructor
///List.generator invokes the creation of an object _Menuoption with
///the value passed as arguments.
class _Menuoption extends StatelessWidget {
  const _Menuoption({required this.label, required this.isSelected , required this.onTap});
  
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context){
    final color = isSelected ? Color(0xFF6B8E23):Color(0xFF2F4F4F);
    final textDecoration = isSelected? TextDecoration.underline: TextDecoration.none;
    
    ///the gesture detector is applied on each of the options
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4),
          Text(
            label,
            style:TextStyle(
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