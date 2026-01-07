import 'package:flutter/material.dart';
import 'package:task_manager_new/data/models/task_list_model.dart';
import 'package:task_manager_new/data/models/task_status_model.dart';
import 'package:task_manager_new/data/services/api_caller.dart';
import 'package:task_manager_new/ui/screens/add_new_task.dart';
import '../../data/utils/urls.dart';
import '../controllers/auth_controller.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/tm_app_bar.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});


  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool _getTaskStatusProgress = false;
  List<TaskStatusData> taskStatusList = [];

  bool _getNewTaskProgress = false;
  List<TaskListData> taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthController.getUserData();
    debugPrint("TOKEN: ✅ ${AuthController.accessToken}");
    _getTaskStatus();
    _getNewTask();
  }

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
              child: Visibility(
                visible: !_getTaskStatusProgress,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemCount: taskStatusList.length,
                    itemBuilder: (context,index){
                    final model = taskStatusList[index];
                      return TaskCountByStatus(
                        title: model.sId ?? "Unknown",
                        count: model.sum ?? 0,
                      );
                    },
                  separatorBuilder: (context,index){
                    return SizedBox(width: 4,);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: !_getNewTaskProgress,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: taskList.length,
                itemBuilder: (context, index){
                  final model = taskList[index];
                    return TaskCard(
                      status: model.status ?? " ",
                      cardColor: Colors.blue,
                      title: model.title ?? '',
                      description: model.description ?? '',
                      date: model.createdDate ?? '',
                      id: model.sId ?? "",
                      onRefreshList: _getNewTask,
                    );
                },
                separatorBuilder: (context,index){
                    return SizedBox(height: 4,);
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTask()));
      },
        child: Icon(Icons.add),
      //shape: ShapeBorde,
      ),
    );
  }

  Future<void> _getTaskStatus() async{
    setState(() {
      _getTaskStatusProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
          url: Urls.taskCountUrl,
      );

      if(response.isSuccess){

        final TaskStatusModel taskStatusModel = TaskStatusModel.fromJson(response.responseData);
        setState(() {
          taskStatusList = taskStatusModel.taskStatusData ?? [];
        });
      }else{
        debugPrint("❌${response.errorMessage}");
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.errorMessage ?? 'Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }

    }catch(e){
      debugPrint("❌$e");
    }finally{
      if(mounted){
        setState(() {
          _getTaskStatusProgress = false;
        });
      }
    }
}

  Future<void> _getNewTask() async{
    setState(() {
      _getNewTaskProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
          url: Urls.taskListByStatusUrl('New'),
      );

      if(response.isSuccess){

        final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
        setState(() {
          taskList = taskListModel.taskListData ?? [];
        });
      }else{
        debugPrint("❌${response.errorMessage}");
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.errorMessage ?? 'Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }

    }catch(e){
      debugPrint("❌$e");
    }finally{
      if(mounted){
        setState(() {
          _getNewTaskProgress = false;
        });
      }
    }
}
}






