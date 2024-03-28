List<Activity> activityFromJson(List<dynamic> activitiesJson) =>
    List<Activity>.from(
        activitiesJson.map((activityJson) => Activity.fromJson(activityJson)));

class Activity {
  String? date;
  List<Activities>? activities;

  Activity({this.date, this.activities});

  Activity.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? id;
  String? logName;
  String? description;
  String? subjectType;
  String? event;
  int? subjectId;
  String? causerType;
  int? causerId;
  Properties? properties;
  String? batchUuid;
  String? activityOf;
  String? createdAt;
  String? updatedAt;

  Activities(
      {this.id,
      this.logName,
      this.description,
      this.subjectType,
      this.event,
      this.subjectId,
      this.causerType,
      this.causerId,
      this.properties,
      this.batchUuid,
      this.activityOf,
      this.createdAt,
      this.updatedAt});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logName = json['log_name'];
    description = json['description'];
    subjectType = json['subject_type'];
    event = json['event'];
    subjectId = json['subject_id'];
    causerType = json['causer_type'];
    causerId = json['causer_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    batchUuid = json['batch_uuid'];
    activityOf = json['activity_of'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['log_name'] = this.logName;
    data['description'] = this.description;
    data['subject_type'] = this.subjectType;
    data['event'] = this.event;
    data['subject_id'] = this.subjectId;
    data['causer_type'] = this.causerType;
    data['causer_id'] = this.causerId;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['batch_uuid'] = this.batchUuid;
    data['activity_of'] = this.activityOf;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Properties {
  String? remarks;
  String? activityOf;

  Properties({this.remarks, this.activityOf});

  Properties.fromJson(Map<String, dynamic> json) {
    remarks = json['remarks'];
    activityOf = json['activity_of'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarks'] = this.remarks;
    data['activity_of'] = this.activityOf;
    return data;
  }
}
