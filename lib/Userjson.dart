class User {
  String? Timein;
  String? Timeout;
  String? Where;

  User({
    this.Timein,
    this.Timeout,
    this.Where,
  });

  Map<String, dynamic> toJson() => {
        'Timein': Timein,
        'Timeout': Timeout,
        'Where': Where,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        Timein: json['Timein'],
        Timeout: json['Timeout'],
        Where: json['Where'],
      );
}
