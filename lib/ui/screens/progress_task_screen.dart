import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/tm_app_bar.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool _inProgress = false;
  List<TaskListData> taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInProgressTask();
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
                  cardColor: Colors.purpleAccent,
                  title: model.title ?? " ",
                  description: model.description ?? " ",
                  date: model.createdDate ?? " ",
                  id: model.sId ?? "",
                  onRefreshList: _getInProgressTask,
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


  Future<void> _getInProgressTask() async{
    setState(() {
      _inProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.taskListByStatusUrl('Progress'),
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
