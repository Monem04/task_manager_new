class TaskListModel {
  String? status;
  List<TaskListData>? taskListData;

  TaskListModel({this.status, this.taskListData});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskListData = <TaskListData>[];
      json['data'].forEach((v) {
        taskListData!.add(TaskListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskListData != null) {
      data['data'] = taskListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskListData {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;

  TaskListData(
      {this.sId,
        this.title,
        this.description,
        this.status,
        this.email,
        this.createdDate});

  TaskListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['email'] = email;
    data['createdDate'] = createdDate;
    return data;
  }
}
