import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/new_task.dart';
import 'package:task_manager_new/ui/screens/progress_task_screen.dart';

import 'cancle_task.dart';
import 'completed_task.dart';
class MainNavBarFolder extends StatefulWidget {
  const MainNavBarFolder({super.key});

  @override
  State<MainNavBarFolder> createState() => _MainNavBarFolderState();
}

class _MainNavBarFolderState extends State<MainNavBarFolder> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NewTask(),
    CompletedTask(),
    CancelTask(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index){
          _selectedIndex = index;
          setState(() {

          });

        },

        destinations: [
        NavigationDestination(icon: Icon(Icons.task), label: 'New'),
        NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
        NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
          NavigationDestination(icon: Icon(Icons.downloading), label: 'Progress'),
      ],
      ),
    );
  }
}
