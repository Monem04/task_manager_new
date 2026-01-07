import 'package:flutter/material.dart';
import 'package:task_manager_new/data/models/task_list_model.dart';
import 'package:task_manager_new/ui/widgets/snackBar.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.status,
    required this.cardColor,
    required this.title,
    required this.description,
    required this.date,
    required this.id,
    required this.onRefreshList,
  });

  final String title;
  final String description;
  final String status;
  final Color cardColor;
  final String date;
  final String id;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 18,
          ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.description),
              Text(widget.date),
              Row(
                children: [
                  Chip(
                    label: Text(widget.status),
                    backgroundColor: widget.cardColor,
                    labelStyle: TextStyle(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ()=> _editStatusDialog(context),
                      icon: Icon(Icons.edit,color: Colors.green,),
                  ),
                  IconButton(
                      onPressed: ()=> _showAlertDialog(context),
                      icon: Icon(Icons.delete_forever,color: Colors.red,),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _editStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Task Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("New"),
                trailing: widget.status == 'New' ? Icon(Icons.check) : null,
              ),
              ListTile(
                title: Text("Progress"),
                trailing: widget.status == 'Progress' ? Icon(Icons.check) : null,
              ),
              ListTile(
                title: Text("Cancel"),
                trailing: widget.status == 'Cancel' ? Icon(Icons.check) : null,
              ),
              ListTile(
                title: Text("Completed"),
                trailing: widget.status == 'Completed' ? Icon(Icons.check) : null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: (){
                _deleteTask();
              },
              child: Text('Yes', style: TextStyle(color: Colors.red)),

            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text("Are you sure? you want to delete this task?\nYou can't undo."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: (){
                _deleteTask();
                },
              child: Text('Yes', style: TextStyle(color: Colors.red)),

            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask() async{
    Navigator.pop(context);

    setState(() {
      _inProgress = true;
    });

    try {
      final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.deleteTaskUrl(widget.id),
      );
      if (response.isSuccess) {
        if (mounted) {
          showSnackBarMessage(
              context, "Task deleted successfully", color: Colors.green);
          widget.onRefreshList.call();
        }
      }
      else {
        debugPrint("❌${response.errorMessage}");
        if (mounted) {
          showSnackBarMessage(
              context, "Something went wrong, Please try again later.",
              color: Colors.red);
        }
      }
    } catch (e) {
      debugPrint("❌$e");
    } finally{
      if(mounted) {
        setState(() {
          _inProgress = false;
        });
      }
    }

  }
}