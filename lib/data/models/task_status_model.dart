class TaskStatusModel {
  String? status;
  List<TaskStatusData>? taskStatusData;

  TaskStatusModel({this.status, this.taskStatusData});

  TaskStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusData = <TaskStatusData>[];
      json['data'].forEach((v) {
        taskStatusData!.add(TaskStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskStatusData != null) {
      data['data'] = taskStatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskStatusData {
  String? sId;
  int? sum;

  TaskStatusData({this.sId, this.sum});

  TaskStatusData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
