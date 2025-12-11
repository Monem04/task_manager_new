import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/add_new_task.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/tm_app_bar.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});


  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: TMAppBar(),
      body: Column(
        children: [
          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context,index){
                    return TaskCountByStatus(title:'Cancelled', count: index+5,);
                  },
                separatorBuilder: (context,index){
                  return SizedBox(width: 4,);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: 10,
              itemBuilder: (context,index){
                  return TaskCard(status: 'New', cardColor: Colors.blue,);
              },
              separatorBuilder: (context,index){
                  return SizedBox(height: 4,);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTask()));
      },child: Icon(Icons.add),
      //shape: ShapeBorde,
      ),
    );
  }
}






