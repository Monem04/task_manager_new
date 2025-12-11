import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/widgets/task_card.dart';
import 'package:task_manager_new/ui/widgets/tm_app_bar.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            itemBuilder: (context, index){
              return TaskCard(status: 'Completed', cardColor: Colors.green,);
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            },
            itemCount: 10),
      ),
    );
  }
}
