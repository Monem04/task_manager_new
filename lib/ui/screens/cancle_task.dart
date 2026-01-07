import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/tm_app_bar.dart';
class CancelTask extends StatefulWidget {
  const CancelTask({super.key});

  @override
  State<CancelTask> createState() => _CancelTaskState();
}

class _CancelTaskState extends State<CancelTask> {

  bool _inProgress = false;
  List<TaskListData> taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCancelTask();
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
                  cardColor: Colors.red,
                  title: model.title ?? " ",
                  description: model.description ?? " ",
                  date: model.createdDate ?? " ",
                  id: model.sId ?? "",
                  onRefreshList: _getCancelTask,
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

  Future<void> _getCancelTask() async{
    setState(() {
      _inProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.taskListByStatusUrl('Cancel'),
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
