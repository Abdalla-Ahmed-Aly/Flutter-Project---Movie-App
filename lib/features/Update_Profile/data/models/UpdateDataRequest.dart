class UpdateDataRequest {
  String? name;
  int? avaterId;
  String? phone;

  UpdateDataRequest({this.name, this.avaterId, this.phone});

  factory UpdateDataRequest.fromJson(Map<String, dynamic> json) {
    return UpdateDataRequest(
      name: json['name'] as String?,
      avaterId: json['avaterId'] as int?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'avaterId': avaterId,
        'phone': phone,
      };
}
