
import 'package:flutter/material.dart';
import 'package:task_manager_new/data/services/api_caller.dart';
import 'package:task_manager_new/data/utils/urls.dart';
import 'package:task_manager_new/ui/widgets/screen_background.dart';
import 'package:task_manager_new/ui/widgets/tm_app_bar.dart';

import '../widgets/snackBar.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionColtroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80,),
                    Text('Add new task',
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title'
                      ),
                      validator: (String ? value){
                        if(value == null || value.isEmpty){
                          return 'please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: descriptionColtroller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Description'
                      ),
                      validator: (String ? value){
                        if(value == null || value.isEmpty){
                          return 'please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    FilledButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        addNewTask();
                      }
                    }, child: Icon(Icons.arrow_circle_right_outlined))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  bool _addTaskProgress = false;

  Future<void> addNewTask() async{
    _addTaskProgress = true;
    setState(() {

    });
    try{
      Map<String, dynamic>requestBody = {
        "title": titleController.text.trim(),
        "description": descriptionColtroller.text.trim(),
        "status": "New",
      };

      final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.createTaskUrls,
        body: requestBody,
      );
      _addTaskProgress = false;

      setState(() {

      });
      if (response.isSuccess) {
        _clearFields();
        if (mounted) {
          showSnackBarMessage(context, 'New Task Added', color: Colors.green);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, response.errorMessage!, color: Colors.red);
        }
      }
    }catch(e){
      debugPrint("❌$e");
    }
  }

  _clearFields(){
    titleController.clear();
    descriptionColtroller.clear();
  }
}
