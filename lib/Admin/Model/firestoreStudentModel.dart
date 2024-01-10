class FirestoreStudentModel {
  String? timein;
  String? timeout;
  String? where;

  FirestoreStudentModel(
      {required this.timein, required this.timeout, required this.where});

  FirestoreStudentModel.fromJson(Map<String, dynamic> json) {
    timein = json['Timein'];
    timeout = json['Timeout'];
    where = json['Where'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timein'] = this.timein;
    data['Timeout'] = this.timeout;
    data['Where'] = this.where;
    return data;
  }
}
