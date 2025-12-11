
import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/widgets/screen_background.dart';
import 'package:task_manager_new/ui/widgets/tm_app_bar.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Text('Add new task',
                style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description'
                  ),
                ),
                const SizedBox(height: 20,),
                FilledButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined))
              ],
            ),
          )),
    );
  }
}
