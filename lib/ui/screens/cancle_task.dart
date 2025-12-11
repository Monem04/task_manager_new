import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/tm_app_bar.dart';
class CancleTask extends StatefulWidget {
  const CancleTask({super.key});

  @override
  State<CancleTask> createState() => _CancleTaskState();
}

class _CancleTaskState extends State<CancleTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            itemBuilder: (context, index){
              return TaskCard(status: 'Canceled', cardColor: Colors.red,);
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            },
            itemCount: 10),
      ),
    );
  }
}
