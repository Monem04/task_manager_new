import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/widgets/task_card.dart';
import 'package:task_manager_new/ui/widgets/tm_app_bar.dart';

import '../../data/models/task_list_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {

  bool _inProgress = false;
  List<TaskListData> taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Visibility(
          visible: !_inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
              itemBuilder: (context, index){
                final model = taskList[index];
                return TaskCard(
                  status: model.status ?? " ",
                  cardColor: Colors.green,
                  title: model.title ?? " ",
                  description: model.description ?? " ",
                  date: model.createdDate ?? " ",
                  id: model.sId ?? "",
                  onRefreshList: _getCompletedTask,
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 5,);
              },
              itemCount: taskList.length),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async{
    setState(() {
      _inProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.taskListByStatusUrl('Completed'),
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
          _inProgress = false;
        });
      }
    }
  }
}
