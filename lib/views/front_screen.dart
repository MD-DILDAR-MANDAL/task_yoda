import 'package:flutter/material.dart';

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
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.menu)),
      ),
   
    );
  }
}

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