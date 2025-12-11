import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/tm_app_bar.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            itemBuilder: (context, index){
              return TaskCard(status: 'Progress', cardColor: Colors.purpleAccent,);
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            },
            itemCount: 10),
      ),
    );
  }
}
