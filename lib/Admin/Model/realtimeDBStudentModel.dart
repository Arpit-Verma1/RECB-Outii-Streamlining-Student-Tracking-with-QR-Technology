class RealtimeDBStudentModel {
  String? name;
  String? timein;
  String? timeout;
  String? phone;
  String? where;

  RealtimeDBStudentModel(
      {this.name, this.timein, this.timeout, this.phone, this.where});

  RealtimeDBStudentModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    timein = json['Timein'];
    timeout = json['Timeout'];
    phone = json['Phone'];
    where = json['Where'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Timein'] = this.timein;
    data['Timeout'] = this.timeout;
    data['Phone'] = this.phone;
    data['Where'] = this.where;
    return data;
  }
}
