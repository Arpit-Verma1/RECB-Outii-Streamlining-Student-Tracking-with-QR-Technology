class RealtimeDBStudentModel {
  late String name;
  late String timein;
  late String timeout;
  late String phone;
  late String where;
  late String branch;
  late String batch;
  late String rollno;

  RealtimeDBStudentModel(
      {required this.name,
      required this.timein,
      required this.timeout,
      required this.phone,
      required this.where,
      required this.branch,
      required this.batch,
      required this.rollno});

  RealtimeDBStudentModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['Name'];
    timein = json['Timein'];
    timeout = json['Timeout'];
    phone = json['Phone'];
    where = json['Where'];
    branch = json['Branch'];
    batch = json['Batch'];
    rollno = json['Rollno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Timein'] = this.timein;
    data['Timeout'] = this.timeout;
    data['Phone'] = this.phone;
    data['Where'] = this.where;
    data['Branch'] = this.branch;
    data['Batch'] = this.batch;
    data['Rollno'] = this.rollno;
    return data;
  }
}
